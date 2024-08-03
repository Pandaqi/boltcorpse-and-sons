class_name MovementEnvironment extends GhostMovementData

@export var move_if_crowded := false
@export var max_range := 780.0

func _process(dt:float, g:Ghost) -> void:
	var closest := ghost_data.get_distance_to_closest(g.position, [g])
	var is_crowded := closest <= max_range
	var should_move = (move_if_crowded == is_crowded)
	if not should_move: return
	
	move_straight(dt, g, speed)
