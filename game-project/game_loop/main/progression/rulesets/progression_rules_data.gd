class_name ProgressionRulesData extends Resource

@export var desc := ""

# these tweak numbers
# they are all FACTORS (change by percentages), not adding/subtracting
@export_subgroup("Number Scalars")
@export var speed_change := 1.0
@export var damage_change := 1.0
@export var health_change := 1.0 # health of ghosts, not player
@export var shield_change := 1.0 # shield of ghosts, not player
@export var spawn_bounds_change := 1.0
@export var spawn_speed_change := 1.0
@export var sight_radius_change := 1.0
@export var kill_radius_change := 1.0

# these are one-time unique effects
@export_subgroup("One-Time Effects")
@export var lives_bonus := 0.0
