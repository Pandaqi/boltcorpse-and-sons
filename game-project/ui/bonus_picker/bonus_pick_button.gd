extends Node2D

@onready var label : Label = $GlassesSprite/Label
@onready var button : Button = $Button
@onready var bonus_picker = get_parent()

var input_action := ""
var data : ProgressionRulesData

signal picked()

func set_data(dir:int, d:ProgressionRulesData):
	var key_hint = "<" if (dir == -1) else ">"
	input_action = "look_left" if (dir == -1) else "look_right"
	label.set_text(key_hint)
	
	button.set_text(d.desc)
	data = d

func _input(ev:InputEvent) -> void:
	if not input_action: return
	if not bonus_picker.is_active(): return
	if not ev.is_action_released(input_action): return
	pick_me()

func _on_button_pressed() -> void:
	pick_me()

func pick_me() -> void:
	picked.emit(data)
