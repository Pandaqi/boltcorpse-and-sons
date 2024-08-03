class_name SpawnerGhosts extends Node2D

@onready var timer : Timer = $Timer
@export var ghost_scene : PackedScene
@export var player_data : PlayerData
@export var ghost_data : GhostData
@export var config : Config

func activate() -> void:
	restart_timer()
	await get_tree().process_frame
	on_timer_timeout()

func restart_timer() -> void:
	timer.wait_time = 3.0
	timer.start()

func on_timer_timeout() -> void:
	spawn_ghost()

func spawn_ghost() -> void:
	var g : Ghost = ghost_scene.instantiate()
	g.set_position(get_random_position_at_screen_edge())
	add_child(g)
	ghost_data.add_ghost(g)
	g.died.connect(func(): ghost_data.remove_ghost(g))
	
	var rand_type : GhostTypeData = ghost_data.ghost_types_available.pick_random()
	g.set_type(rand_type)
	g.set_visible(player_data.should_ghost_be_visible(g))

func get_random_position_at_screen_edge() -> Vector2:
	var vp = get_viewport_rect().size
	var offset := 32.0 # remember that this offset is in screen coordinates, not world, so don't use 256 (half the sprite's width) here!
	var screen_pos := Vector2(-offset, randf()*vp.y)
	if randf() <= 0.5:
		screen_pos.x = vp.x+offset
	
	var world_pos := get_viewport().get_canvas_transform().affine_inverse() * screen_pos
	
	# if the camera is (still) moving around, it can happen we spawn too close to the player
	# so just move use to the min distance away then
	var too_close := world_pos.distance_to(player_data.player.position) < config.min_spawn_dist_to_player
	if too_close:
		var dir := -1 if randf() <= 0.5 else 1
		world_pos.x = player_data.player.position.x + dir * config.min_spawn_dist_to_player
	
	return world_pos
