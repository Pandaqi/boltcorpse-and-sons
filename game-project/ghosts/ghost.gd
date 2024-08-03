class_name Ghost extends Node2D

@onready var health : ModuleHealth = $Health
@onready var mover : ModuleMover = $Mover
@onready var sprite : Sprite2D = $Sprite2D
@onready var weaknesses : ModuleWeaknesses = $Weaknesses
@onready var anim_player : AnimationPlayer = $AnimationPlayer
@onready var audio_player : AudioStreamPlayer2D = $AudioAppear
@onready var audio_death : AudioStreamPlayer2D = $AudioDeath
@onready var light : ModuleLight = $Light
@export var config : Config

var type : GhostTypeData
var dead := false

signal died()
signal appearance_changed(is_visible:bool)

func _ready() -> void:
	health.depleted.connect(on_death)
	mover.moved.connect(on_moved)
	audio_player.pitch_scale = randf_range(0.9, 1.1)
	audio_player.play()

func set_type(t:GhostTypeData) -> void:
	type = t
	
	sprite.set_frame(type.frame)
	
	health.set_base_health(type.health * config.ghosts_def_health)
	health.refill()
	
	mover.set_resource(type.movement)
	weaknesses.set_elements(type.weak_glasses)
	type.weaknesses_changed.connect(weaknesses.set_elements)
	
	light.set_active(type.self_light)

func on_moved(vec:Vector2) -> void:
	if vec.length() <= 0.00003: return
	sprite.flip_h = vec.x < 0 # sprites face right by default, so flip if we COME from the right = moving left

func on_death() -> void:
	if dead: return
	
	set_visible(true) # to make sure you always see their death animation
	dead = true
	died.emit()
	audio_death.pitch_scale = randf_range(0.9, 1.1)
	audio_death.play()
	anim_player.play("die")
	await anim_player.animation_finished
	self.queue_free()

func change_appearance(vis:bool) -> void:
	set_visible(vis)
	appearance_changed.emit(vis)
