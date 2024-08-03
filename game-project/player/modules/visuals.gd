class_name ModuleVisuals extends Node2D

@onready var sprite : Sprite2D = $Sprite2D
@onready var anim_player : AnimationPlayer = $AnimationPlayer
@export var sprite_size := Vector2(512.0, 512.0)

func activate(l:ModuleLooker, lives:ModuleLives) -> void:
	l.dir_changed.connect(on_dir_changed)
	lives.lives_changed.connect(on_lives_changed)

func on_lives_changed(_new_lives:int) -> void:
	anim_player.play("flash")

func on_dir_changed(dir:int) -> void:
	sprite.flip_h = dir < 0
