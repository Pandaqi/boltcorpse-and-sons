class_name ModuleGhostFeeler extends Node

@onready var entity : Player = get_parent()
@export var ghost_data : GhostData

func _process(_dt:float) -> void:
	check_for_overlapping_ghosts()

func check_for_overlapping_ghosts() -> void:
	var ghosts := ghost_data.ghosts
	for ghost in ghosts:
		var dist_sq = ghost.position.distance_squared_to(entity.position)
		var range_sq := pow(ghost.type.range, 2)
		if dist_sq > range_sq: continue
		trigger_overlap(ghost)

# @TODO: we'll do custom effects and cleaner/modular code later
func trigger_overlap(ghost:Ghost) -> void:
	entity.lives.change_lives(-1)
	ghost.health.drain()
	# @TODO: unleash a curse connected to the ghost, if it exists
