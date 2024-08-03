class_name ModuleHealth extends Node2D

var base_health := 100.0
var health := 0.0
@onready var prog_bar : TextureProgressBar = $TextureProgressBar

const HEALTHY_COLOR := Color(28/255.0, 255/255.0, 142/255.0)
const DYING_COLOR := Color(219/255.0, 69/255.0, 51/255.0)

signal depleted()

func set_base_health(h:float) -> void:
	base_health = h

func drain() -> void:
	update_health(-health)

func refill() -> void:
	health = 0
	update_health(base_health)

func get_health_ratio() -> float:
	return health / base_health

func update_health(h:float) -> void:
	health = clamp(health + h, 0.0, base_health)
	
	var ratio := get_health_ratio()
	prog_bar.value = ratio * 100
	prog_bar.tint_progress = HEALTHY_COLOR
	if ratio <= 0.33:
		prog_bar.tint_progress = DYING_COLOR

	if health <= 0:
		prog_bar.set_visible(false)
		depleted.emit()
