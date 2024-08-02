class_name GhostData extends Resource

var ghosts : Array[Ghost] = []

func reset() -> void:
	ghosts = []

func add_ghost(g:Ghost) -> void:
	ghosts.append(g)

func remove_ghost(g:Ghost) -> void:
	ghosts.erase(g)

func get_all_visible() -> Array[Ghost]:
	var arr : Array[Ghost] = []
	for ghost in ghosts:
		if not ghost.visible: continue
		arr.append(ghost)
	return arr
