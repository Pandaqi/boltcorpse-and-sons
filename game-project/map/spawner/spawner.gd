class_name SpawnerGhosts extends Node2D

@onready var timer : Timer = $Timer
@export var ghost_scene : PackedScene
@export var player_data : PlayerData
@export var ghost_data : GhostData
@export var config : Config
@export var prog_data : ProgressionData

func activate() -> void:
	ghost_data.ghost_removed.connect(on_ghost_removed)
	await get_tree().process_frame
	on_timer_timeout()
	
	# @TODO: this should really be on Map itself, but it has no Config reference
	if OS.is_debug_build() and config.debug_no_darkness:
		get_parent().canvas_modulate.set_visible(false)

func restart_timer() -> void:
	timer.wait_time = prog_data.interpolate(config.spawn_interval_bounds) * prog_data.rules_data.spawn_speed_change
	timer.start()

func on_ghost_removed(_g:Ghost) -> void:
	check_ghost_spawn_numbers()

func on_timer_timeout() -> void:
	check_ghost_spawn_numbers(true)
	restart_timer()

func check_ghost_spawn_numbers(from_tick := false) -> void:
	var num_ghosts := ghost_data.count()
	var global_change := prog_data.rules_data.spawn_bounds_change
	var max_num : int = round(prog_data.interpolate(config.spawn_bounds_max) * global_change)
	if num_ghosts >= max_num: return
	
	var min_num : int = round(prog_data.interpolate(config.spawn_bounds_min) * global_change)
	while num_ghosts < min_num:
		spawn_ghost()
		num_ghosts += 1
	
	if from_tick:
		var too_far_below_maximum := true
		while too_far_below_maximum:
			spawn_ghost()
			num_ghosts += 1
			too_far_below_maximum = num_ghosts < 0.5*max_num

func spawn_ghost() -> void:
	print("SPAWNING GHOST")
	
	# first, determine if we have a valid type to spawn (and if so, pick one)
	var type_options : Array[GhostTypeData] = ghost_data.ghost_types_available.duplicate(false)
	type_options.shuffle()
	
	var chosen_option : GhostTypeData
	for option in type_options:
		var num_in_level := ghost_data.get_frequency_of(option)
		var max_num := option.max_num
		if num_in_level >= max_num: continue
		chosen_option = option
		break
	
	if not chosen_option: return
	
	var g : Ghost = ghost_scene.instantiate()
	g.set_position(get_random_position_at_screen_edge())
	add_child(g)
	ghost_data.add_ghost(g)
	g.died.connect(func(): ghost_data.remove_ghost(g))
	
	g.set_type(chosen_option)
	g.set_visible(player_data.should_ghost_be_visible(g))

func get_random_position_at_screen_edge() -> Vector2:
	var vp = get_viewport_rect().size
	var world_pos := Vector2.ZERO

	var num_tries := 0
	var max_tries := 75
	var bad_pos := true
	while bad_pos:
		bad_pos = false
		num_tries += 1
		if num_tries >= max_tries: break
		
		var screen_pos := Vector2(0, randf()*vp.y)
		if randf() <= 0.5: screen_pos.x = vp.x
		
		world_pos = get_viewport().get_canvas_transform().affine_inverse() * screen_pos
		
		# if the camera is (still) moving around, it can happen we spawn too close to the player
		# so just move use to the min distance away then
		var too_close_to_player := world_pos.distance_to(player_data.player.position) < config.min_spawn_dist_to_player
		if too_close_to_player:
			var dir := -1 if randf() <= 0.5 else 1
			world_pos.x = player_data.player.position.x + dir * config.min_spawn_dist_to_player
		
		# if we're too close to another ghost, don't fix, just retry on next loop iteration
		var too_close_to_ghost := ghost_data.get_distance_to_closest(world_pos) < 512.0
		if too_close_to_ghost:
			bad_pos = true
	
	return world_pos
