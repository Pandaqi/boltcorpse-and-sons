extends Node2D

@onready var ghost_sprite : Sprite2D = $Ghost
@onready var desc : Label = $Label
@onready var stats = {
	"health": $Stats/Health,
	"shield": $Stats/Shield,
	"speed": $Stats/Speed,
	"damage": $Stats/Damage
}

func set_data(d:GhostTypeData) -> void:
	ghost_sprite.set_frame(d.frame)
	desc.set_text(d.desc)
	
	stats.health.set_frame(get_frame_for_diff(d.health - 1.0))
	stats.shield.set_frame(get_frame_for_diff(d.shield - 0.0))
	stats.speed.set_frame(get_frame_for_diff(d.speed - 1.0))
	stats.damage.set_frame(get_frame_for_diff(d.lives_taken - 1))

func get_frame_for_diff(diff:float) -> int:
	if diff > 0.03: return 5
	elif diff < -0.03: return 6
	return 7
