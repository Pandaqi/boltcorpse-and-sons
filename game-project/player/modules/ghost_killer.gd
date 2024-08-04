class_name ModuleGhostKiller extends Node2D

@export var ghost_data : GhostData
@export var glasses_data : GlassesData
@export var prog_data : ProgressionData
@onready var kill_radius : Sprite2D = $KillRadiusContainer/KillRadius
@onready var kill_radius_anim : AnimationPlayer = $KillRadiusContainer/AnimationPlayer
@onready var entity : Player = get_parent()
@export var config : Config

var kill_radius_extra_scale := 0.0
var damage_extra_scale := 0.0
var stats_tracker : ModuleStatsTracker

func activate(s:ModuleStatsTracker, l:ModuleLooker) -> void:
	l.dir_changed.connect(on_dir_changed)
	glasses_data.glasses_changed.connect(on_glasses_changed)
	on_glasses_changed(glasses_data.get_current_glasses())
	stats_tracker = s
	
	kill_radius.set_visible(config.display_kill_radius)
	if kill_radius.is_visible():
		kill_radius_anim.play("random_fade")

func on_dir_changed(_new_dir:int) -> void:
	reset_kill_radius()

func on_glasses_changed(_new_glasses:GlassesTypeData) -> void:
	reset_kill_radius()

func _process(dt: float) -> void:
	grow_damage(dt)
	grow_kill_radius(dt)
	display_kill_radius()
	
	modify_speed_of_visible_ghosts()
	damage_all_visible_ghosts(dt)

func grow_damage(dt:float) -> void:
	if not config.staying_in_view_changes_damage: return
	damage_extra_scale += config.damage_change_in_view * dt

func reset_kill_radius():
	kill_radius_extra_scale = 0.0
	damage_extra_scale = 0.0
	display_kill_radius()

func grow_kill_radius(dt:float) -> void:
	if not config.staying_in_view_changes_kill_radius: return
	kill_radius_extra_scale += config.kill_radius_change_in_view * dt

func display_kill_radius() -> void:
	# divide by base sprite size, multiply by 2 because scale is full width and radius only half the circle of course
	var range_as_scale := calculate_kill_range()/128.0 * 2
	kill_radius.set_scale(Vector2.ONE * range_as_scale)

func modify_speed_of_visible_ghosts() -> void:
	var ghosts := ghost_data.get_all_on_viewed_side()
	var cur_glasses := glasses_data.get_current_glasses()
	for ghost in ghosts:
		ghost.mover.set_speed_scale(cur_glasses.ghost_speed_scale)

func damage_all_visible_ghosts(dt:float) -> void:
	var ghosts := ghost_data.get_all_on_viewed_side()
	var cur_glasses := glasses_data.get_current_glasses()
	
	for ghost in ghosts:
		if not ghost.type.weak_to_glasses(cur_glasses): continue
		
		var out_of_range := ghost.global_position.distance_to(entity.global_position) > calculate_kill_range()
		if out_of_range: continue
		
		var damage := calculate_damage_from_glasses(ghost.type, cur_glasses)
		damage *= dt
		ghost.health.update_health(-damage)
		
		if ghost.dead:
			stats_tracker.killed_ghost(ghost)

func calculate_kill_range() -> float:
	return (glasses_data.get_current_glasses().range_kill * config.glasses_def_range_kill) * prog_data.rules_data.kill_radius_change + kill_radius_extra_scale

func calculate_damage_from_glasses(tp:GhostTypeData, g:GlassesTypeData) -> float:
	if OS.is_debug_build() and config.debug_no_damage: return 0.0
	
	var raw_damage := (g.damage * config.glasses_def_damage * prog_data.rules_data.damage_change) + damage_extra_scale
	var shield := 0.0 if g.pierce_shield else (tp.shield * config.ghosts_def_shield * prog_data.rules_data.shield_change)
	return clamp(raw_damage - shield, 0.0, 999.0)
