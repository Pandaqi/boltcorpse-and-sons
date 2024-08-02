class_name GhostMovementData extends Resource

@export var speed := 50.0
var player_data : PlayerData = preload("res://player/player_data.tres")

func _process(dt:float, g:Ghost) -> void:
	if not player_data.player: return
	
	var vec : Vector2 = g.global_position.direction_to(player_data.player.global_position).normalized()
	var new_pos = g.get_position() + vec * speed * dt
	g.set_position(new_pos)
