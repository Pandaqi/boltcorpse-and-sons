class_name ProgressionData extends Resource

var start_time := 0.0 # ms
var cur_time := 0.0

@export var config : Config

signal something_unlocked()

func reset() -> void:
	start_time = Time.get_ticks_msec()

func update_time() -> void:
	cur_time = Time.get_ticks_msec()

func get_time_elapsed_seconds() -> float:
	return (cur_time - start_time) / 1000.0

func get_ratio() -> float:
	return clamp(get_time_elapsed_seconds() / config.prog_max_time, 0.0, 1.0)

func interpolate(val:Dictionary) -> float:
	return lerp(val.min, val.max, get_ratio())
