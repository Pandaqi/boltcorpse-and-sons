class_name ModuleMover extends Node2D

var res : GhostMovementData
var speed_scale := 1.0
@onready var entity : Ghost = get_parent()
@export var player_data : PlayerData
@export var ghost_data : GhostData
@export var prog_data : ProgressionData

var prev_move_vec := Vector2.ZERO

signal moved(vec:Vector2)

func _ready():
	entity.appearance_changed.connect(on_appearance_changed)

func set_resource(r:GhostMovementData) -> void:
	res = r.duplicate(true)
	res.init(entity.config.ghosts_def_speed, player_data, ghost_data)
	
	if res.has_method("_ready"):
		res._ready(get_tree())

func _process(dt:float) -> void:
	if entity.dead: return
	if not res: return
	if not res.has_method("_process"): return
	
	var cur_pos = entity.position
	var final_speed = speed_scale * prog_data.rules_data.speed_change
	res._process(dt * final_speed, entity)
	prev_move_vec = entity.position - cur_pos
	moved.emit(prev_move_vec)

func set_speed_scale(ss:float) -> void:
	speed_scale = ss

func on_appearance_changed(_vis:bool) -> void:
	speed_scale = 1.0
