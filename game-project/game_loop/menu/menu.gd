extends Control

func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(preload("res://game_loop/main/main.tscn"))

func _on_quit_pressed() -> void:
	get_tree().quit()
