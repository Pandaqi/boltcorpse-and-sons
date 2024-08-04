extends Node

signal spirit_help()

func _ready():
	var a = AudioStreamPlayer.new()
	a.stream = preload("res://game_loop/background_ambience.ogg")
	a.volume_db = -21
	a.set_process_mode(Node.PROCESS_MODE_ALWAYS)
	add_child(a)
	a.play()
