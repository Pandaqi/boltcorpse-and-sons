class_name MovementVaried extends GhostMovementData

var going_forward := true
var timed_out := false
var time_elapsed := 0.0

@export var timer_duration_min := 3.0
@export var timer_duration_max := 5.0
@export var timer_duration_flipped_factor := 0.5
@export var flip_on_timeout := false
@export var only_move_on_timeout := false

func _ready(tree:SceneTree) -> void:
	start_timer(tree)

func start_timer(tree:SceneTree) -> void:
	var dur := randf_range(timer_duration_min, timer_duration_max)
	
	 # always move further forward than backward, otherwise we don't have guarantee we'll reach the player
	if not going_forward: 
		var avg_time := 0.5 * (timer_duration_min + timer_duration_max)
		dur = timer_duration_flipped_factor * avg_time
	
	await tree.create_timer(dur).timeout
	on_timer_timeout()
	start_timer(tree)

func on_timer_timeout() -> void:
	timed_out = true
	if flip_on_timeout:
		going_forward = not going_forward

func _process(dt:float, g:Ghost) -> void:
	time_elapsed += dt
	
	var dir := 1 if going_forward else -1
	var cur_speed := dir * speed
	
	if only_move_on_timeout:
		dt = time_elapsed if timed_out else 0.0
	
	move_straight(dt, g, cur_speed)
	
	if timed_out:
		timed_out = false
		time_elapsed = 0.0
