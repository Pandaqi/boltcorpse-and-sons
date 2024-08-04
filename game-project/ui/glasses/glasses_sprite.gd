extends Node2D

@onready var bg : Sprite2D = $BG
@onready var tex : Sprite2D = $Sprite2D
@onready var key_hint : Sprite2D = $KeyHint
@onready var label : Label = $KeyHint/Label
@onready var anim_player : AnimationPlayer = $AnimationPlayer
@export var glasses_data : GlassesData

var type : GlassesTypeData
var focused := false

var is_clickable := false
var num := -1

func _ready() -> void:
	key_hint.set_visible(false)

func highlight() -> void:
	set_scale(1.2*Vector2.ONE)
	set_modulate(Color(3,3,3))
	anim_player.play("wobble")

func unhighlight() -> void:
	set_modulate(Color(1,1,1,0.66))
	anim_player.stop(false)

func focus() -> void:
	if focused: return
	
	var tw = get_tree().create_tween()
	tw.tween_property(self, "scale", 1.3*Vector2.ONE, 0.1)
	tw.tween_property(self, "scale", 1.2*Vector2.ONE, 0.05) 
	
	focused = true

func unfocus() -> void:
	if not focused: return
	
	var tw = get_tree().create_tween()
	tw.tween_property(self, "scale", 0.9*Vector2.ONE, 0.1)
	tw.tween_property(self, "scale", 1*Vector2.ONE, 0.05) 

	focused = false

func is_type(d:GlassesTypeData) -> bool:
	return type == d

func set_data(n:int, d:GlassesTypeData) -> void:
	type = d
	
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
