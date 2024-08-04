class_name ModuleLives extends Node2D

var lives := 0

@onready var audio_player : AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var particles : CPUParticles2D = $ParticlesLifeLost
@export var config : Config

signal empty()
signal lives_changed(new_lives:int)

func activate() -> void:
	change_lives(config.lives_starting_num)

func change_lives(dl:int) -> void:
	lives = clamp(lives + dl, 0, config.lives_max)
	lives_changed.emit(lives)
	
	if dl < 0:
		audio_player.pitch_scale = randf_range(0.9, 1.1)
		audio_player.play()
		show_particles()
	
	if lives <= 0:
		empty.emit()
	
	if config.spirit_help_provide_on_life_lost:
		await audio_player.finished
		GSignalBus.spirit_help.emit()

func show_particles() -> void:
	particles.set_emitting(true)
	await get_tree().process_frame
	particles.set_emitting(false)
