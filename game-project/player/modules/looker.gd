class_name ModuleLooker extends Node2D

var dir := 0
var sight_radius_extra_scale := 0.0

@onready var entity : Player = get_parent()
@onready var flash_light = $Flashlight
@onready var light : PointLight2D = $Flashlight/PointLight2D
@onready var audio_player : AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var sight_radius : Sprite2D = $SightRadiusContainer/SightRadius
@onready var sight_radius_anim : AnimationPlayer = $SightRadiusContainer/AnimationPlayer
@export var player_data : PlayerData
@export var ghost_data : GhostData
@export var glasses_data : GlassesData
@export var prog_data : ProgressionData
@export var config : Config

signal dir_changed(new_dir:int)

func activate() -> void:
	look_to_side(1)
	animate()
	glasses_data.glasses_changed.connect(on_glasses_changed)
	on_glasses_changed(glasses_data.get_current_glasses())
	
	sight_radius.set_visible(config.display_sight_radius)
	if sight_radius.is_visible(): sight_radius_anim.play("random_fade")

func animate() -> void:
	var tw := get_tree().create_tween()
	var rand_scale := Vector2(randf()*0.1 + 0.95, randf()*0.1 + 0.95)
	var rand_alpha := randf() * 0.2 + 0.8
	var rand_dur := randf_range(0.25, 0.5)
	tw.tween_property(light, "scale", rand_scale, rand_dur)
	tw.parallel().tween_property(light, "color:a", rand_alpha, rand_dur)
	
	rand_dur = randf_range(0.25, 0.5)
	tw.tween_property(light, "scale", Vector2.ONE, rand_dur)
	tw.parallel().tween_property(light, "color:a", 1.0, rand_dur)
	tw.tween_callback(animate)

func _process(dt:float) -> void:
	grow_sight_radius(dt)
	display_sight_radius()

func grow_sight_radius(dt:float) -> void:
	if not config.staying_in_view_changes_sight_radius: return
	sight_radius_extra_scale += config.sight_radius_change_in_view * dt

func display_sight_radius() -> void:
	var range_sight := glasses_data.get_current_glasses().range_see * config.glasses_def_range_see + sight_radius_extra_scale
	var range_as_scale := range_sight/128.0 * 2 # divide by base sprite size, multiply by 2 because scale is full width and radius only half the circle of course
	sight_radius.set_scale(Vector2.ONE * range_as_scale)

func _input(ev:InputEvent) -> void:
	var side := 0
	
	if ev.is_action_released("look_left"):
		side = -1
	elif ev.is_action_released("look_right"):
		side = +1
	elif ev is InputEventMouseButton:
		var not_over_ui : bool = ev.position.y < (get_viewport_rect().size.y-128.0)
		if not_over_ui:
			side = -1 if get_global_mouse_position().x < entity.position.x else +1
	
	if side == 0: return
	look_to_side(side)

func look_to_side(new_dir:int) -> void:
	if dir == new_dir: return

	dir = new_dir
	flash_light.scale.x = new_dir
	player_data.side_looking = dir
	
	reset_extra_radius() # @NOTE: comes before checking ghosts, because range matters for it!
	check_ghost_appearance()
	
	dir_changed.emit(dir)
	
	audio_player.pitch_scale = randf_range(0.9, 1.1)
	audio_player.play()

func check_ghost_appearance() -> void:
	var all_ghosts := ghost_data.ghosts
	for ghost in all_ghosts:
		ghost.change_appearance(player_data.should_ghost_be_visible(ghost))

func calculate_sight_range() -> float:
	return (glasses_data.get_current_glasses().range_see * config.glasses_def_range_see * prog_data.rules_data.sight_radius_change) + sight_radius_extra_scale

func ghost_is_in_range(ghost:Ghost) -> bool:
	return ghost.global_position.distance_to(entity.global_position) <= calculate_sight_range()

func set_light_properties(col:Color, tex:Texture2D) -> void:
	light.color = col
	light.texture = tex

func on_glasses_changed(_new_glasses:GlassesTypeData) -> void:
	reset_extra_radius()
	check_ghost_appearance()

func reset_extra_radius():
	sight_radius_extra_scale = 0.0
	display_sight_radius()
