class_name ModuleGhostKiller extends Node

@export var ghost_data : GhostData
@export var glasses_data : GlassesData

var stats_tracker : ModuleStatsTracker

func activate(s:ModuleStatsTracker) -> void:
	stats_tracker = s

func _process(dt: float) -> void:
	damage_all_visible_ghosts(dt)

func damage_all_visible_ghosts(dt) -> void:
	var ghosts := ghost_data.get_all_visible()
	var cur_glasses := glasses_data.get_current_glasses()
	for ghost in ghosts:
		if not ghost.type.weak_to_glasses(cur_glasses): continue
		
		var damage := calculate_damage_from_glasses(ghost.type, cur_glasses)
		damage *= dt
		ghost.health.update_health(-damage)
		
		if ghost.dead:
			stats_tracker.killed_ghost(ghost)

func calculate_damage_from_glasses(tp:GhostTypeData, g:GlassesTypeData) -> float:
	return clamp(g.damage - tp.shield, 0.0, 999.0)
