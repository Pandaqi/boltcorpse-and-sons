class_name Ghost extends Node2D

@onready var health : ModuleHealth = $Health
@onready var mover : ModuleMover = $Mover

var type : GhostTypeData
var dead := false

signal died()

func _ready() -> void:
	health.depleted.connect(on_death)

func set_type(t:GhostTypeData) -> void:
	type = t
	
	health.set_base_health(type.health)
	health.refill()
	
	mover.set_resource(type.movement)

func on_death() -> void:
	dead = true
	self.queue_free()
	died.emit()
