class_name MovementFloatSimple extends GhostMovementData

@export var only_when_looking := false
@export var speed_scale_start := 1.0
@export var speed_scale_end := 1.0
@export var speed_scale_max_dist := 3000

func _process(dt:float, g:Ghost) -> void:
	if not player_data.player: return
	
	# basically weeping angels only
	if only_when_looking and player_data.on_viewed_side(g): return
	
	# depending on distance to player, we speed up or slow down
	var ratio_traveled_raw := g.position.distance_to(player_data.player.position) / speed_scale_max_dist
	var ratio_traveled_clamped = 1.0 - clamp(ratio_traveled_raw, 0.0, 1.0)
	
	var cur_speed : float = speed * lerp(speed_scale_start, speed_scale_end, ratio_traveled_clamped)
	
	# finally, move towards player with our current settings
	move_straight(dt, g, cur_speed)
