class_name ProgressionData extends Resource

var start_time := 0.0 # ms
var cur_time := 0.0
var max_time := 300.0

signal something_unlocked()

func reset(tm:float, mt:float) -> void:
	max_time = mt
	start_time = tm

func update_time(tm:float) -> void:
	cur_time = tm

func get_time_elapsed_seconds() -> float:
	return (cur_time - start_time) / 1000.0

func get_ratio() -> float:
	if max_time <= 0.003: return 0.0
	return clamp(get_time_elapsed_seconds() / max_time, 0.0, 1.0)

func interpolate(val:Dictionary) -> float:
	return lerp(val.min, val.max, get_ratio())
