class_name ModuleLives extends Node

var lives := 0

signal empty()
signal lives_changed(new_lives:int)

# @TODO: read num starting lives from config
func activate() -> void:
	change_lives(3)

func change_lives(dl:int) -> void:
	lives = clamp(lives + dl, 0, 5)
	lives_changed.emit(lives)
	
	if lives <= 0:
		empty.emit()
