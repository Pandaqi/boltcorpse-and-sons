class_name GhostData extends Resource

@export var all_ghosts : Array[GhostTypeData] = []
@export var starting_ghosts : Array[GhostTypeData] = []
@export var player_data : PlayerData

var ghost_types_available : Array[GhostTypeData] = []
var ghosts : Array[Ghost] = []

signal ghost_removed(g:Ghost)
signal ghost_added(g:Ghost)

func reset() -> void:
	ghosts = []
	ghost_types_available = []

func unlock_ghost_type(tp:GhostTypeData) -> void:
	ghost_types_available.append(tp)

func add_ghost(g:Ghost) -> void:
	ghosts.append(g)
	ghost_added.emit(g)

func remove_ghost(g:Ghost) -> void:
	ghosts.erase(g)
	ghost_removed.emit(g)

func count() -> float:
	return ghosts.size()

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

func get_distance_to_closest(pos:Vector2, exclude : Array[Ghost] = []) -> float:
	var closest := INF
	for ghost in ghosts:
		if exclude.has(ghost): continue
		closest = min(pos.distance_to(ghost.position), closest)
	return closest

# @TODO: this is very expensive; it would be cheaper to keep a dictionary of frequencies at all times, updated on add_ and remove_ calls
func get_frequency_of(tp:GhostTypeData) -> int:
	var num := 0
	for ghost in ghosts:
		if ghost.type == tp: num += 1
	return num
