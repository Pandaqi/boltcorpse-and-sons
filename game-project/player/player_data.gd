class_name PlayerData extends Resource

var side_looking := 1
var player : Player

func should_ghost_be_visible(ghost:Ghost) -> bool:
	return ghost.position.x * side_looking > player.position.x * side_looking
