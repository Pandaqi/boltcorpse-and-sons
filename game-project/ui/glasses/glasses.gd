class_name UIGlasses extends Node2D

var sprite_size := 92.0
var sprites := []
@export var glasses_sprite : PackedScene
@export var glasses_data : GlassesData

var cur_highlighted_node = null

func activate() -> void:
	glasses_data.index_changed.connect(highlight_index)
	glasses_data.elements_changed.connect(update_glasses)

func on_resize() -> void:
	var vp = get_viewport_rect().size
	set_position(Vector2(0.5*vp.x, vp.y - sprite_size*1.15))

func highlight_index(idx:int) -> void:
	if cur_highlighted_node: cur_highlighted_node.unfocus()
	cur_highlighted_node = sprites[idx]
	cur_highlighted_node.focus()

func update_glasses(_new_glasses:Array[GlassesTypeData]) -> void:
	var new_num = glasses_data.count()
	while sprites.size() < new_num:
		var new_sprite = glasses_sprite.instantiate()
		sprites.append(new_sprite)
		add_child(new_sprite)
	
	var offset_per_sprite := Vector2.RIGHT * sprite_size
	var global_offset : Vector2 = -0.5 * (new_num - 1) * offset_per_sprite
	for i in range(sprites.size()):
		var should_show = i < new_num
		var sprite = sprites[i]
		sprite.set_visible(should_show)
		sprite.set_position(global_offset + i * offset_per_sprite)
		sprite.set_data(i, glasses_data.elements[i])
		sprite.enable_key_hint()
