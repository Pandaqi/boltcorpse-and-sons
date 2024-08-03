extends Node2D

@onready var glasses_bg : Sprite2D = $GlassesSprite/BG
@onready var glasses_sprite : Sprite2D = $GlassesSprite/Sprite2D
@onready var desc : Label = $Label
@onready var stats = {
	"damage": $Stats/Damage,
	"range_see": $Stats/RangeSee,
	"range_kill": $Stats/RangeKill,
	"ghost_speed_scale": $Stats/GhostSpeed
}

func set_data(d:GlassesTypeData) -> void:
	glasses_sprite.set_frame(d.frame)
	glasses_bg.modulate = d.light_color
	desc.set_text(d.desc)
	
	stats.damage.set_frame(get_frame_for_diff(d.damage - 1.0))
	stats.range_see.set_frame(get_frame_for_diff(d.range_see - 1.0))
	stats.range_kill.set_frame(get_frame_for_diff(d.range_kill - 1.0))
	stats.ghost_speed_scale.set_frame(get_frame_for_diff(d.ghost_speed_scale - 1.0))

func get_frame_for_diff(diff:float) -> int:
	if diff > 0.03: return 5
	elif diff < -0.03: return 6
	return 7
