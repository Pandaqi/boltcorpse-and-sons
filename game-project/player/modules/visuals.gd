class_name ModuleVisuals extends Node2D

@onready var sprite : Sprite2D = $Sprite2D
@onready var anim_player : AnimationPlayer = $AnimationPlayer
@onready var sprite_glasses : Sprite2D = $Sprite2D/Glasses
@export var sprite_size := Vector2(512.0, 512.0)
@export var glasses_data : GlassesData

func activate(l:ModuleLooker, lives:ModuleLives) -> void:
	l.dir_changed.connect(on_dir_changed)
	lives.lives_changed.connect(on_lives_changed)
	glasses_data.glasses_changed.connect(on_glasses_changed)

func on_lives_changed(_new_lives:int) -> void:
	anim_player.play("flash")

func on_dir_changed(dir:int) -> void:
	sprite.scale.x = dir

func on_glasses_changed(new_glasses:GlassesTypeData) -> void:
	sprite_glasses.set_frame(new_glasses.frame)
	
