class_name GhostMovementData extends Resource

@export var speed := 1.0

var def_speed := 0.0
var player_data : PlayerData
var ghost_data : GhostData

func init(def:float, p:PlayerData, g:GhostData):
	player_data = p
	def_speed = def
	ghost_data = g

func move_straight(dt:float, g:Ghost, cur_speed := 1.0) -> void:
	if not player_data.player: return
	
	var vec : Vector2 = g.position.direction_to(player_data.player.position).normalized()
	var final_speed = cur_speed * g.type.speed * def_speed
	
	move(g, vec * final_speed * dt)

func move(g:Ghost, vec:Vector2) -> void:
	g.set_position(g.position + vec)
