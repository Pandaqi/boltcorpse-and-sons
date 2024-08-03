class_name Map extends Node2D

@onready var spawner : SpawnerGhosts = $SpawnerGhosts
@onready var canvas_modulate : CanvasModulate = $CanvasModulate
@onready var bg : Sprite2D = $BG

func activate() -> void:
	spawner.activate()

func _process(_dt:float) -> void:
	keep_background_full_size()

func keep_background_full_size() -> void:
	var aff_inv := get_viewport().get_canvas_transform().affine_inverse()
	var world_top_left := aff_inv * Vector2.ZERO
	var world_bottom_right := aff_inv * get_viewport_rect().size
	bg.region_rect = Rect2(0, 0, world_bottom_right.x - world_top_left.x, world_bottom_right.y - world_top_left.y)
