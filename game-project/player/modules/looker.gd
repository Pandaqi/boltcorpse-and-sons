class_name ModuleLooker extends Node2D

var dir := 1
@onready var entity : Player = get_parent()
@onready var flash_light = $Flashlight
@export var player_data : PlayerData
@export var ghost_data : GhostData

signal dir_changed(new_dir:int)

func activate() -> void:
	look_to_side(1)

func _input(ev:InputEvent) -> void:
	var side := 0
	
	if ev.is_action_released("look_left"):
		side = -1
	elif ev.is_action_released("look_right"):
		side = +1
	elif ev is InputEventMouseButton:
		side = +1
		if get_global_mouse_position().x < entity.position.x: 
			side = -1
	
	if side == 0: return
	look_to_side(side)

func look_to_side(new_dir:int) -> void:
	dir = new_dir
	flash_light.scale.x = new_dir
	player_data.side_looking = dir
	reveal_ghosts_on_our_side()
	dir_changed.emit(dir)

# @TODO: probably want a distance check as well, depending on default value + glasses
func reveal_ghosts_on_our_side() -> void:
	var all_ghosts := ghost_data.ghosts
	for ghost in all_ghosts:
		ghost.set_visible(player_data.should_ghost_be_visible(ghost))
