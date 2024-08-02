class_name Map extends Node2D

@onready var spawner : SpawnerGhosts = $SpawnerGhosts

func activate() -> void:
	spawner.activate()
