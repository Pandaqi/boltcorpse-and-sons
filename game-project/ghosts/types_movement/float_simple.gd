class_name MovementFloatSimple extends GhostMovementData

var config : Config = preload("res://game_loop/globals/config.tres")
var player_data : PlayerData = preload("res://player/player_data.tres")

func _process(dt:float, g:Ghost) -> void:
	if not player_data.player: return
	
	var vec : Vector2 = g.global_position.direction_to(player_data.player.global_position).normalized()
	var final_speed = speed * config.ghosts_def_speed
	var new_pos = g.get_position() + vec * final_speed * dt
	g.set_position(new_pos)
