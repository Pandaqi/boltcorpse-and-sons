class_name ModuleGhostFeeler extends Node

@onready var entity : Player = get_parent()
@export var ghost_data : GhostData
@export var glasses_data : GlassesData
@export var config : Config

func _process(_dt:float) -> void:
	check_for_overlapping_ghosts()

func check_for_overlapping_ghosts() -> void:
	var ghosts := ghost_data.ghosts
	for ghost in ghosts:
		var dist_sq = ghost.position.distance_squared_to(entity.position)
		var range_sq := pow(ghost.type.range_attack * config.ghosts_def_range_attack, 2)
		if dist_sq > range_sq: continue
		trigger_overlap(ghost)

func trigger_overlap(ghost:Ghost) -> void:
	var lives_lost = ghost.type.lives_taken
	var override = glasses_data.get_current_glasses().lives_taken_override
	if override > -1: lives_lost = override
	
	entity.lives.change_lives(-lives_lost)
	ghost.health.drain()
	
	for effect in ghost.type.effects:
		effect.trigger()
