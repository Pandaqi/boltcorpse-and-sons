class_name UI extends CanvasLayer

@onready var lives : UILives = $Lives
@onready var glasses : UIGlasses = $Glasses
@onready var game_over : GameOver = $GameOver

func activate(p:Player):
	get_tree().get_root().size_changed.connect(on_resize)
	lives.activate(p)
	glasses.activate()
	game_over.activate()
	on_resize()

func on_resize() -> void:
	lives.on_resize()
	glasses.on_resize()
