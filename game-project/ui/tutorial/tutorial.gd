class_name Tutorial extends Node2D

@onready var tut_ghost = $TutorialGhost
@onready var tut_glasses = $TutorialGlasses
@onready var starting_hints = $StartingHints
@onready var starting_hint_left = $StartingHints/StartingHintLeft
@onready var starting_hint_right = $StartingHints/StartingHintRight
@onready var starting_hint_timer : Timer = $StartingHints/Timer
@export var modal_scale := 0.5
@export var config : Config
@onready var audio_player : AudioStreamPlayer = $AudioStreamPlayer

var active := false
var active_node = null
var first_show := true

signal dismissed()

func activate() -> void:
	tut_ghost.set_visible(false)
	tut_glasses.set_visible(false)
	active = false
	
	starting_hints.set_visible(false)

func on_resize() -> void:
	var vp_size = get_viewport_rect().size
	starting_hint_left.set_position(Vector2(0.125*vp_size.x, 0.5*vp_size.y))
	starting_hint_right.set_position(Vector2(0.875*vp_size.x, 0.5*vp_size.y))
	
	tut_ghost.set_position(0.5*vp_size)
	tut_glasses.set_position(0.5*vp_size)

func appear(elements:Array) -> void:
	for elem in elements:
		appear_single(elem)
		await self.dismissed
	
	if first_show:
		first_show = false
		plan_starting_hint_removal()

func appear_single(element) -> void:
	get_tree().paused = true
	
	var node = tut_glasses if (element is GlassesTypeData) else tut_ghost
	node.set_scale(Vector2.ZERO)
	node.set_visible(true)
	node.modulate.a = 0.0
	active_node = node
	
	audio_player.play()
	
	node.set_data(element)
	
	var dur := 0.2
	var tw = get_tree().create_tween()
	tw.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tw.tween_property(node, "scale", 1.2*modal_scale*Vector2.ONE, dur)
	tw.parallel().tween_property(node, "modulate:a", 1.0, dur)
	tw.tween_property(node, "scale", modal_scale*Vector2.ONE, 0.5*dur)
	
	await tw.finished

	active = true

func disappear() -> void:
	var tw = get_tree().create_tween()
	tw.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tw.tween_property(active_node, "modulate:a", 0.0, 0.5)
	await tw.finished
	active_node.set_visible(false)
	active = false
	get_tree().paused = false
	dismissed.emit()

func _input(ev:InputEvent) -> void:
	if not active: return
	if not ev.is_action_released("dismiss_tutorial"): return
	disappear()

func plan_starting_hint_removal() -> void:
	starting_hints.set_visible(true)
	starting_hint_timer.wait_time = config.prog_starting_hints_fade_delay
	starting_hint_timer.start()

func _on_timer_timeout() -> void:
	var arr = [starting_hint_left, starting_hint_right]
	for elem in arr:
		var tw = get_tree().create_tween()
		tw.tween_property(elem, "modulate:a", 0.0, 2.0)
