class_name ModuleGhostEffects extends Node2D

@onready var audio_player : AudioStreamPlayer2D = $AudioWhispers
@onready var timer : Timer = $Timer

func _ready() -> void:
	restart_timer()

func restart_timer() -> void:
	timer.wait_time = randf_range(5.0, 20.0)
	timer.start()

func _on_timer_timeout() -> void:
	audio_player.pitch_scale = randf_range(0.9, 1.1)
	audio_player.play()
