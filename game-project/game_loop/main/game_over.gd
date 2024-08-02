class_name GameOver extends Control

@onready var anim_player : AnimationPlayer = $AnimationPlayer

var active := false

func activate():
	active = false
	set_visible(false)

func appear() -> void:
	get_tree().paused = true
	set_visible(true)
	
	# @TODO: update the stats
	
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
	pass
	#get_tree().change_scene_to_packed(preload("res://game_loop/menu/menu.tscn"))

func _on_continue_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
