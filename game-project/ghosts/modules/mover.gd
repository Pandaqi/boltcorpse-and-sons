class_name ModuleMover extends Node2D

var res : GhostMovementData
var speed_scale := 1.0
@onready var entity : Ghost = get_parent()

func _ready():
	entity.appearance_changed.connect(on_appearance_changed)

func set_resource(r:GhostMovementData) -> void:
	res = r

func _process(dt:float) -> void:
	if entity.dead: return
	if not res: return
	if not res.has_method("_process"): return
	res._process(dt * speed_scale, entity)

func set_speed_scale(ss:float) -> void:
	speed_scale = ss

func on_appearance_changed(_vis:bool) -> void:
	speed_scale = 1.0
