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
	
	# @NOTE: because we set the sprites in order of elems, which is just the list directly from glasses_data, everything should have the SAME ORDER as inventory (which is nice)
	for elem in elems:
		var s = glasses_sprite.instantiate()
		add_child(s)
		sprites.append(s)
		s.set_data(-1, elem)
	
	var offset_per_sprite := Vector2.RIGHT * sprite_size
	var global_offset := -0.5 * (sprites.size() - 1) * offset_per_sprite
	for i in range(sprites.size()):
		sprites[i].set_position(global_offset + i * offset_per_sprite)
