class_name GhostTypeData extends Resource

@export var range := 64.0
@export var weak_glasses : Array[GlassesTypeData] = []
@export var health := 100.0
@export var shield := 0.0
@export var movement : GhostMovementData = preload("res://ghosts/types_movement/float_simple.tres")

func weak_to_glasses(g:GlassesTypeData) -> bool:
	return weak_glasses.has(g)
