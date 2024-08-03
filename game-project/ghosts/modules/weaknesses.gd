class_name ModuleWeaknesses extends Node2D

@export var glasses_sprite : PackedScene
@export var glasses_data : GlassesData
var sprites := []
var sprite_size := 92.0

func _ready() -> void:
	get_parent().died.connect(on_death)

func on_death() -> void:
	set_visible(false)

func set_elements(elems:Array[GlassesTypeData]) -> void:
	for sprite in sprites:
		sprite.queue_free()
	
	sprites = []
	for elem in elems:
		var s = glasses_sprite.instantiate()
		add_child(s)
		sprites.append(s)
		s.set_data(-1, elem)
	
	var offset_per_sprite := Vector2.RIGHT * sprite_size
	var global_offset := -0.5 * (sprites.size() - 1) * offset_per_sprite
	for i in range(sprites.size()):
		var num_in_inventory = glasses_data.get_index_of(elems[i]) # this means it's always sorted the same as your inventory, which is much nicer
		sprites[i].set_position(global_offset + num_in_inventory * offset_per_sprite)
