class_name ModuleMover extends Node2D

var res : GhostMovementData
@onready var entity : Ghost = get_parent()

func set_resource(r:GhostMovementData) -> void:
	res = r

func _process(dt:float) -> void:
	if not res: return
	if not res.has_method("_process"): return
	res._process(dt, entity)
