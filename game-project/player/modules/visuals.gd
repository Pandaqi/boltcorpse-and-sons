class_name ModuleVisuals extends Node2D

@onready var sprite : Sprite2D = $Sprite2D

func activate(l:ModuleLooker) -> void:
	l.dir_changed.connect(on_dir_changed)

func on_dir_changed(dir:int) -> void:
	sprite.flip_v = dir < 0

# @TODO: need something cleaner for centering/zooming camera, but this'll do for now
func get_bounds() -> Rect2:
	var sprite_size := Vector2(256.0, 256.0)
	return Rect2(global_position.x -0.5*sprite_size.x, global_position.y -0.5*sprite_size.y, sprite_size.x, sprite_size.y)
