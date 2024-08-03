class_name Progression extends Node

@export var prog_data : ProgressionData 
@export var glasses_data : GlassesData
@export var ghost_data : GhostData
@export var config : Config

@onready var timer_unlock : Timer = $TimerUnlock

var game_over : GameOver
var is_done := false
var starting_elements := []

var element_order := []
var tutorial : Tutorial

var unlock_interval : = 0.0

func activate(p:Player, go:GameOver, t:Tutorial) -> void:
	game_over = go
	tutorial = t
	prog_data.reset()
	p.lives.empty.connect(on_lives_empty)
	
	unlock_interval = config.prog_interval_between_unlocks
	generate_unlock_order()

func generate_unlock_order() -> void:
	# grab all possible glasses and ghosts that can appear
	# cut out the ones we must start with
	glasses_data.reset()
	var starting_glasses = glasses_data.starting_glasses
	var all_glasses = glasses_data.all_glasses.duplicate(false)
	for g in starting_glasses:
		all_glasses.erase(g)
		starting_elements.append(g)
		unlock_glasses(g)
	all_glasses.shuffle()
	
	ghost_data.reset()
	var starting_ghosts = ghost_data.starting_ghosts
	var all_ghosts = ghost_data.all_ghosts.duplicate(false)
	for g in starting_ghosts:
		all_ghosts.erase(g)
		starting_elements.append(g)
		unlock_ghost(g)
	all_ghosts.shuffle()
	
	# pick from both lists, alternating, until both depleted
	var arr = []
	var pick_glasses := config.prog_glasses_unlock_first
	while all_glasses.size() + all_ghosts.size() > 0:
		var pick_ghost : bool = ((not pick_glasses) or all_glasses.size() <= 0) and all_ghosts.size() > 0
		if pick_ghost: arr.append(all_ghosts.pop_back())
		else: arr.append(all_glasses.pop_back())
		pick_glasses = not pick_glasses
	
	element_order = arr

func on_lives_empty() -> void:
	if is_done: return
	
	print("GAME OVER!")
	is_done = true
	game_over.appear()

func on_timer_timeout() -> void:
	prog_data.update_time()

func start_game() -> void:
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
		var should_adopt := (i-randf()+1)/num_types <= threshold or num_types <= 1
		var can_adopt : bool = types_unlocked[i].count_weaknesses() < config.ghosts_max_weaknesses
		if should_adopt and can_adopt:
			types_unlocked[i].add_weakness(tp) 

func unlock_ghost(tp:GhostTypeData) -> void:
	# which glasses work on a particular ghost are determined by which are unlocked so far
	# but the NEWEST is always used, to ensure there's at least one ghost for each glasses type
	var weak_glasses : Array[GlassesTypeData] = [glasses_data.elements.back()]
	for i in range(glasses_data.elements.size()-1):
		var should_include := randf() <= config.prog_include_old_weak_glasses_prob
		if should_include:
			weak_glasses.append(glasses_data.elements[i])
	
	tp.set_weaknesses(weak_glasses)
	ghost_data.unlock_ghost_type(tp)
