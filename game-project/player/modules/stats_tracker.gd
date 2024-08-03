class_name ModuleStatsTracker extends Node

@export var prog_data : ProgressionData
@export var config : Config

var ghosts_killed : Array[Ghost] = []
var score := 0.0

@onready var entity : Player = get_parent()

func _ready():
	prog_data.something_unlocked.connect(on_something_unlocked)

func killed_ghost(g:Ghost):
	ghosts_killed.append(g)

	# each ghost has a default score
	var extra_score := g.type.value * config.score_def_per_ghost_killed
	
	# make it higher if you've survived longer
	extra_score *= 1.0 + prog_data.get_ratio()
	
	# and a bonus for killing them earlier
	var dist_to_player : float = entity.position.distance_to(g.position) / config.glasses_def_range_see
	extra_score *= 1.0 + clamp(dist_to_player, 0.0, 1.0)

	update_score(extra_score)

func on_something_unlocked() -> void:
	update_score(config.score_def_per_unlock)

func update_score(ds:float) -> void:
	score = clamp(score + ds, 0.0, 9999.9)
