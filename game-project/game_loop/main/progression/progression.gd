class_name Progression extends Node

@export var prog_data : ProgressionData 
@export var glasses_data : GlassesData
@export var ghost_data : GhostData
@export var config : Config

@onready var timer_unlock : Timer = $TimerUnlock

var rules_data : ProgressionRulesData
var game_over : GameOver
var is_done := false
var starting_elements := []

var element_order := []
var tutorial : Tutorial

var unlock_interval : = 0.0

func activate(p:Player, go:GameOver, t:Tutorial) -> void:
	game_over = go
	tutorial = t
	prog_data.reset(config.prog_scale_automatically, Time.get_ticks_msec(), config.prog_max_time)
	p.lives.empty.connect(on_lives_empty)
	
	unlock_interval = config.prog_interval_between_unlocks
	generate_unlock_order()

func generate_unlock_order() -> void:
	# grab all possible glasses and ghosts that can appear
	# cut out the ones we must start with
	glasses_data.reset()
	var starting_glasses = glasses_data.starting_glasses
	if OS.is_debug_build() and config.debug_force_glasses.size() > 0:
		starting_glasses = config.debug_force_glasses
	
	var all_glasses = glasses_data.all_glasses.duplicate(false)
	for g in starting_glasses:
		all_glasses.erase(g)
		starting_elements.append(g)
		unlock_glasses(g)
	all_glasses.shuffle()
	
	ghost_data.reset()
	var starting_ghosts = ghost_data.starting_ghosts
	if OS.is_debug_build() and config.debug_force_ghosts.size() > 0:
		starting_ghosts = config.debug_force_ghosts
	
	var all_ghosts = ghost_data.all_ghosts.duplicate(false)
	for g in starting_ghosts:
		all_ghosts.erase(g)
		starting_elements.append(g)
		unlock_ghost(g)
	all_ghosts.shuffle()
	
	# pick from both lists, alternating, until both depleted
	var arr = []
	var cycle_between_glasses := config.prog_cycle_between_glasses
	var last_glasses_time := randi_range(0, cycle_between_glasses)
	if config.prog_glasses_unlock_first:
		last_glasses_time = 0
	
	while all_glasses.size() + all_ghosts.size() > 0:
		var pick_ghost = (last_glasses_time != 0 and all_ghosts.size() > 0) or all_glasses.size() <= 0
		if pick_ghost: arr.append(all_ghosts.pop_back())
		else: arr.append(all_glasses.pop_back())
		last_glasses_time = (last_glasses_time + 1) % cycle_between_glasses
	
	element_order = arr

func on_lives_empty() -> void:
	if is_done: return
	
	print("GAME OVER!")
	is_done = true
	game_over.appear()

func on_timer_timeout() -> void:
	prog_data.update_time(Time.get_ticks_msec())

func start_game() -> void:
	var skip_tutorial = OS.is_debug_build() and config.debug_skip_pregame
	if not skip_tutorial:
		tutorial.appear(starting_elements)
	restart_unlock_timer()

func _on_timer_unlock_timeout() -> void:
	if element_order.size() <= 0: return
	var new_elem = element_order.pop_front()
	if new_elem is GlassesTypeData: 
		unlock_glasses(new_elem)
	else: 
		unlock_ghost(new_elem)
	
	tutorial.appear([new_elem])
	restart_unlock_timer()
	prog_data.something_unlocked.emit()

func restart_unlock_timer() -> void:
	timer_unlock.wait_time = unlock_interval
	timer_unlock.start()
	unlock_interval = clamp(unlock_interval + config.prog_interval_added_per_unlock, 1.0, config.prog_interval_max)

func unlock_glasses(tp:GlassesTypeData) -> void:
	glasses_data.add_element(tp)
	
	var types_unlocked := ghost_data.ghost_types_available.duplicate(false)
	var num_types := types_unlocked.size()
	types_unlocked.shuffle()
	var threshold := config.prog_ghost_perc_to_adopt_new_glasses
	for i in range(num_types):
		# if there's just one ghost, we always want to adopt, otherwise the new glasses are useless now AND we can't "break into percentage" one thing anyway
		var should_adopt := (i-randf()+1.0)/num_types <= threshold or num_types <= 1
		var can_adopt : bool = types_unlocked[i].count_weaknesses() < config.ghosts_max_weaknesses
		if should_adopt and can_adopt:
			types_unlocked[i].add_weakness(tp) 

func unlock_ghost(tp:GhostTypeData) -> void:
	# which glasses work on a particular ghost are determined by which are unlocked so far
	# but the NEWEST is always used, to ensure there's at least one ghost for each glasses type
	var weak_glasses : Array[GlassesTypeData] = [glasses_data.elements.back()]
	for i in range(glasses_data.elements.size()-1):
		var should_include := randf() <= config.prog_include_old_weak_glasses_prob
		if not should_include: continue
		weak_glasses.append(glasses_data.elements[i])
	
	tp.set_weaknesses(weak_glasses)
	ghost_data.unlock_ghost_type(tp)
