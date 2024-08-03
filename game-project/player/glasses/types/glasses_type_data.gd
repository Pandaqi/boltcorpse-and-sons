class_name GlassesTypeData extends Resource

@export var frame := 0
@export var damage := 1.0
@export var light_color := Color(1,1,1)
@export var light_shape : Texture2D = preload("res://player/light_sprites/light_sprite_cone.webp")
@export var range_kill := 1.0 
@export var range_see := 1.0
@export var desc := ""

@export var pierce_shield := false
@export var ghost_speed_scale := 1.0 # to slow down or speed up ghosts
@export var lives_taken_override := -1 # instead of the lives the ghost wants to take, you lose this
