class_name ModuleLight extends Node2D

@onready var anim_player : AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	anim_player.speed_scale = randf_range(0.3, 0.75)
	anim_player.play("flicker")
	get_parent().died.connect(on_death)

func set_active(val:bool) -> void:
	set_visible(val)

func on_death() -> void:
	set_visible(false)
