class_name Progression extends Node

@export var prog_data : ProgressionData 

var game_over : GameOver
var is_done := false

func activate(p:Player, go:GameOver) -> void:
	game_over = go
	prog_data.reset()
	p.lives.empty.connect(on_lives_empty)

func on_lives_empty() -> void:
	if is_done: return
	
	print("GAME OVER!")
	is_done = true
	game_over.appear()

func on_timer_timeout() -> void:
	prog_data.update_time()
