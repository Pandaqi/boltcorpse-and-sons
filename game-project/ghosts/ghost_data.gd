class_name GhostData extends Resource

@export var all_ghosts : Array[GhostTypeData] = []
@export var starting_ghosts : Array[GhostTypeData] = []
@export var player_data : PlayerData

var ghost_types_available : Array[GhostTypeData] = []
var ghosts : Array[Ghost] = []

func reset() -> void:
	ghosts = []
	ghost_types_available = []

func unlock_ghost_type(tp:GhostTypeData) -> void:
	ghost_types_available.append(tp)

func add_ghost(g:Ghost) -> void:
	ghosts.append(g)

func remove_ghost(g:Ghost) -> void:
	ghosts.erase(g)

func get_all_visible() -> Array[Ghost]:
	var arr : Array[Ghost] = []
	for ghost in ghosts:
		if not ghost.is_visible(): continue
		arr.append(ghost)
	return arr

func get_all_in_range() -> Array[Ghost]:
	var arr : Array[Ghost] = []
	for ghost in ghosts:
		if not player_data.in_range(ghost): continue
		arr.append(ghost)
	return arr

func get_all_on_viewed_side() -> Array[Ghost]:
	var arr : Array[Ghost] = []
	for ghost in ghosts:
		if not player_data.on_viewed_side(ghost): continue
		arr.append(ghost)
	return arr
