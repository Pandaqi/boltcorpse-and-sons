class_name GameOver extends Control

@export var player_data : PlayerData
@onready var anim_player : AnimationPlayer = $AnimationPlayer
@onready var rich_label : RichTextLabel = $CenterContainer/VBoxContainer/RichTextLabel
@onready var audio_player : AudioStreamPlayer = $AudioStreamPlayer

var active := false

func activate():
	active = false
	set_visible(false)

func appear() -> void:
	audio_player.play()
	
	# QOL: to let sound effects and animations play out
	await get_tree().create_timer(1.0).timeout
	
	get_tree().paused = true
	set_visible(true)
	
	var stats := player_data.player.stats_tracker
	var txt : String = "You managed to chase away [b]" + str(stats.ghosts_killed.size()) + " ghosts[/b] and rack up [b]" + str(round(stats.score)) + " points[/b].\n\nPerhaps there is a future for you at [i]Boltcorpse & Sons[/i]. If you were still alive."
	rich_label.set_text(txt)
	
	anim_player.play("game_over_appear")
	await anim_player.animation_finished
	active = true

func _input(ev:InputEvent) -> void:
	if not active: return
	if ev.is_action_pressed("ui_accept"):
		_on_continue_pressed()
	elif ev.is_action_pressed("ui_cancel"):
		_on_back_pressed()

func _on_back_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_packed(preload("res://game_loop/menu/menu.tscn"))

func _on_continue_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
