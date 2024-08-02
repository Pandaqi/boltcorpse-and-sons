class_name SpawnerGhosts extends Node2D

@onready var timer : Timer = $Timer
@export var ghost_scene : PackedScene
@export var player_data : PlayerData
@export var ghost_data : GhostData

func activate() -> void:
	ghost_data.reset()
	restart_timer()

func restart_timer() -> void:
	timer.wait_time = 3.0
	timer.start()

func on_timer_timeout() -> void:
	spawn_ghost()

func spawn_ghost() -> void:
	var g : Ghost = ghost_scene.instantiate()
	g.set_position(get_random_position_at_screen_edge())
	g.set_visible(player_data.should_ghost_be_visible(g))
	add_child(g)
	ghost_data.add_ghost(g)
	g.died.emit(func(): ghost_data.remove_ghost(g))
	
	g.set_type(preload("res://ghosts/types/regular_ghost.tres"))

func get_random_position_at_screen_edge() -> Vector2:
	var vp = get_viewport_rect().size
	var screen_pos := Vector2(0, randf()*vp.y)
	if randf() <= 0.5:
		screen_pos.x = vp.x
	
	var world_pos := get_viewport().get_canvas_transform().affine_inverse() * screen_pos
	return world_pos
