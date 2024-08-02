class_name ModuleGlassesPicker extends Node

@export var glasses_data : GlassesData

func activate() -> void:
	# @TODO: figure out where all glasses resources would be saved and how we initialize them/with how many we start
	glasses_data.add_element(preload("res://player/glasses/types/regular_glasses.tres"))

func _input(ev:InputEvent) -> void:
	if ev.is_action_released("pick_glasses_previous"):
		glasses_data.pick_relative(-1)
	elif ev.is_action_released("pick_glasses_next"):
		glasses_data.pick_relative(+1)
	elif ev is InputEventKey and not ev.pressed:
		var key_string : String = OS.get_keycode_string(ev.keycode)
		var key_num := int(key_string.right(1))
		if not is_nan(key_num) and key_num > 0 and key_num <= 9: 
			print(key_num)
			glasses_data.pick_absolute(key_num - 1) # @NOTE: assume that player thinks 1 = first element
