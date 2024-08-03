class_name GhostTypeData extends Resource

@export var frame := 0
@export var desc := "Your regular friendly ghost doing nothing special."
@export var range_attack := 1.0 # the range in which it can grab the player
@export var lives_taken := 1 # how many lives it takes upon contact
@export var weak_glasses : Array[GlassesTypeData] = []
@export var health := 1.0
@export var shield := 0.0
@export var movement : GhostMovementData
@export var effects : Array = [] # @TODO: type-hint this once I have actual effects
@export var self_light := true
@export var value := 1.0 # modifies what score you get for killing them, and perhaps difficulty settings later

signal weaknesses_changed(new_weak:Array[GlassesTypeData])

func count_weaknesses() -> int:
	return weak_glasses.size()

func weak_to_glasses(g:GlassesTypeData) -> bool:
	return weak_glasses.has(g)

func set_weaknesses(list:Array[GlassesTypeData]) -> void:
	weak_glasses = list
	weaknesses_changed.emit(weak_glasses)

func add_weakness(g:GlassesTypeData) -> void:
	weak_glasses.append(g)
	weaknesses_changed.emit(weak_glasses)
