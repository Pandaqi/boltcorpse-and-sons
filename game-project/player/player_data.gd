class_name PlayerData extends Resource

var side_looking := 1
var player : Player

func on_viewed_side(ghost:Ghost) -> bool:
	return ghost.position.x * side_looking > player.position.x * side_looking

func in_range(ghost:Ghost) -> bool:
	return player.looker.ghost_is_in_range(ghost)

func should_ghost_be_visible(ghost:Ghost) -> bool:
	return on_viewed_side(ghost) and in_range(ghost)
