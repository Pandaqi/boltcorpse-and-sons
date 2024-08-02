extends Node2D

@onready var map : Map = $Map
@onready var player : Player = $Player
@onready var ui : UI = $UI
@onready var progression : Progression = $Progression

func _ready() -> void:
	progression.activate(player, ui.game_over)
	ui.activate(player) # as usual, UI is connected BEFORE initializing anything else, so UI automatically initializes with it later
	map.activate()
	player.activate()
	
	
