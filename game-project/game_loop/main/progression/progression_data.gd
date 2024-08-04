class_name ProgressionData extends Resource

var start_time := 0.0 # ms
var cur_time := 0.0
var max_time := 300.0
var auto_scale := false

@export var all_rulesets : Array[ProgressionRulesData] = []
@export var default_rules : ProgressionRulesData
@export var auto_scale_rules : ProgressionRulesData
var rules_data : ProgressionRulesData

signal something_unlocked()

func reset(auto:bool, tm:float, mt:float) -> void:
	auto_scale = auto
	max_time = mt
	start_time = tm
	rules_data = default_rules.duplicate(true)

func update_time(tm:float) -> void:
	cur_time = tm
	update_auto_scale_properties()

func apply_ruleset(d:ProgressionRulesData) -> void:
	rules_data.speed_change *= d.speed_change
	rules_data.damage_change *= d.damage_change
	
	rules_data.health_change *= d.health_change
	rules_data.shield_change *= d.shield_change
	
	rules_data.spawn_bounds_change *= d.spawn_bounds_change
	rules_data.spawn_speed_change *= d.spawn_speed_change
	
	rules_data.sight_radius_change *= d.sight_radius_change
	rules_data.kill_radius_change *= d.kill_radius_change

func update_auto_scale_properties():
	if not auto_scale: return
	
	var r := get_ratio()
	
	rules_data.speed_change = lerp(default_rules.speed_change, auto_scale_rules.speed_change, r)
	rules_data.damage_change = lerp(default_rules.damage_change, auto_scale_rules.damage_change, r)
	
	rules_data.health_change = lerp(default_rules.health_change, auto_scale_rules.health_change, r)
	rules_data.shield_change = lerp(default_rules.shield_change, auto_scale_rules.shield_change, r)
	
	rules_data.spawn_bounds_change = lerp(default_rules.spawn_bounds_change, auto_scale_rules.spawn_bounds_change, r)
	rules_data.spawn_speed_change = lerp(default_rules.spawn_speed_change, auto_scale_rules.spawn_speed_change, r)
	
	rules_data.sight_radius_change = lerp(default_rules.sight_radius_change, auto_scale_rules.sight_radius_change, r)
	rules_data.kill_radius_change = lerp(default_rules.kill_radius_change, auto_scale_rules.kill_radius_change, r)

func get_time_elapsed_seconds() -> float:
	return (cur_time - start_time) / 1000.0

func get_ratio() -> float:
	if max_time <= 0.003: return 0.0
	return clamp(get_time_elapsed_seconds() / max_time, 0.0, 1.0)

func interpolate(val:Dictionary) -> float:
	return lerp(val.min, val.max, get_ratio())
