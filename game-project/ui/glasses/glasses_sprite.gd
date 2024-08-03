extends Node2D

@onready var bg : Sprite2D = $BG
@onready var tex : Sprite2D = $Sprite2D
@onready var key_hint : Sprite2D = $KeyHint
@onready var label : Label = $KeyHint/Label
@export var glasses_data : GlassesData

var is_clickable := false
var num := -1

func _ready() -> void:
	key_hint.set_visible(false)

func focus() -> void:
	var tw = get_tree().create_tween()
	tw.tween_property(self, "scale", 1.3*Vector2.ONE, 0.1)
	tw.tween_property(self, "scale", 1.2*Vector2.ONE, 0.05) 

func unfocus() -> void:
	var tw = get_tree().create_tween()
	tw.tween_property(self, "scale", 0.9*Vector2.ONE, 0.1)
	tw.tween_property(self, "scale", 1*Vector2.ONE, 0.05) 

func set_data(n:int, d:GlassesTypeData) -> void:
	num = n
	bg.modulate = d.light_color
	tex.set_frame(d.frame)
	label.set_text(str(n + 1))

func enable_key_hint():
	key_hint.set_visible(true)
	is_clickable = true

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if not is_clickable: return
	if not (event is InputEventMouseButton): return
	if event.pressed: return
	glasses_data.pick_absolute(num)
