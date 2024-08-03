class_name ModuleGhostKiller extends Node2D

@export var ghost_data : GhostData
@export var glasses_data : GlassesData
@onready var kill_radius : Sprite2D = $KillRadiusContainer/KillRadius
@onready var kill_radius_anim : AnimationPlayer = $KillRadiusContainer/AnimationPlayer
@onready var entity : Player = get_parent()
@export var config : Config

var stats_tracker : ModuleStatsTracker

func activate(s:ModuleStatsTracker) -> void:
	glasses_data.glasses_changed.connect(on_glasses_changed)
	on_glasses_changed(glasses_data.get_current_glasses())
	stats_tracker = s
	
	kill_radius.set_visible(config.display_kill_radius)
	if kill_radius.is_visible():
		kill_radius_anim.play("random_fade")

func on_glasses_changed(new_glasses:GlassesTypeData) -> void:
	var range := new_glasses.range_kill * config.glasses_def_range_kill
	var range_as_scale := range/128.0 * 2
	kill_radius.set_scale(Vector2.ONE * range_as_scale)

func _process(dt: float) -> void:
	damage_all_visible_ghosts(dt)

func damage_all_visible_ghosts(dt:float) -> void:
	var ghosts := ghost_data.get_all_on_viewed_side()
	var cur_glasses := glasses_data.get_current_glasses()
	for ghost in ghosts:
		ghost.mover.set_speed_scale(cur_glasses.ghost_speed_scale)
		
		if not ghost.type.weak_to_glasses(cur_glasses): continue
		
		var out_of_range := ghost.position.distance_to(entity.position) > (cur_glasses.range_kill * config.glasses_def_range_kill)
		if out_of_range: return
		
		var damage := calculate_damage_from_glasses(ghost.type, cur_glasses)
		damage *= dt
		ghost.health.update_health(-damage)
		
		if ghost.dead:
			stats_tracker.killed_ghost(ghost)

func calculate_damage_from_glasses(tp:GhostTypeData, g:GlassesTypeData) -> float:
	var raw_damage := g.damage * config.glasses_def_damage
	var shield := 0.0 if g.pierce_shield else tp.shield
	return clamp(raw_damage - shield, 0.0, 999.0)
