extends Node2D

@onready var anim_player : AnimationPlayer = $AnimationPlayer
var is_active := false

func change_visible(vis:bool):
	if vis: anim_player.play("appear")
	else: anim_player.play_backwards("appear")
	is_active = vis
