extends Node2D

@export var prog_data : ProgressionData
@onready var btn_left = $BonusPickButtonLeft
@onready var btn_right = $BonusPickButtonRight
@onready var tutorial : Tutorial = get_parent()

func _ready() -> void:
	btn_left.picked.connect(on_picked)
	btn_right.picked.connect(on_picked)

func set_data(_elem) -> void:
	var all_rulesets = prog_data.all_rulesets.duplicate(false)
	all_rulesets.shuffle()
	
	btn_left.set_data(-1, all_rulesets.pop_back())
	btn_right.set_data(+1, all_rulesets.pop_back())

func on_picked(d:ProgressionRulesData) -> void:
	prog_data.apply_ruleset(d)
	tutorial.disappear()

func is_active() -> bool:
	return tutorial.active
