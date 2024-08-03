class_name ModuleGlassesPicker extends Node2D

var looker : ModuleLooker
@export var glasses_data : GlassesData
@onready var audio_player : AudioStreamPlayer2D = $AudioStreamPlayer2D

func activate(l:ModuleLooker) -> void:
	looker = l
	glasses_data.index_changed.connect(on_glasses_changed)
	glasses_data.pick_relative(0)

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

func on_glasses_changed(_new_index:int) -> void:
	var data = glasses_data.get_current_glasses()
	looker.set_light_properties(data.light_color, data.light_shape)
	
	audio_player.pitch_scale = randf_range(0.9, 1.1)
	audio_player.play()
