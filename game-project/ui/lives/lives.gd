class_name UILives extends Node2D

var sprites = []
var sprite_size := 64.0

@export var life_sprite : PackedScene

func activate(p:Player) -> void:
	p.lives.lives_changed.connect(update_lives)

func on_resize() -> void:
	var vp = get_viewport_rect().size
	set_position(Vector2(0.5*vp.x, sprite_size))

func update_lives(new_lives:int) -> void:
	while sprites.size() < new_lives:
		var new_sprite = life_sprite.instantiate()
		sprites.append(new_sprite)
		add_child(new_sprite)
	
	var offset_per_sprite := Vector2.RIGHT * sprite_size
	var global_offset := -0.5 * (new_lives - 1) * offset_per_sprite
	for i in range(sprites.size()):
		var should_show = i < new_lives
		var sprite = sprites[i]
		sprite.set_position(global_offset + i * offset_per_sprite)
		
		var change_needed = (should_show != sprite.is_active)
		if not change_needed: continue
		
		sprite.change_visible(should_show)
		
