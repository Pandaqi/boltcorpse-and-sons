extends Camera2D

const MOVE_SPEED := 8.0
const ZOOM_SPEED := 8.0
# @NOTE: the generous margin on Y ensures that we get a good zoomed-out view, but also that we have space for the UI above and below
const CAMERA_EDGE_MARGIN := Vector2(32.0, 256.0)

@export var player_data : PlayerData

func _process(dt:float):
	fit_bounds_in_view(dt)

func fit_bounds_in_view(dt:float):
	if not player_data.player: return
	
	var map_bounds := player_data.player.visuals.get_bounds()
	var target_position := map_bounds.get_center()
	
	var vp_size := get_viewport_rect().size - 2*CAMERA_EDGE_MARGIN
	var map_size := map_bounds.size
	var ratios := vp_size / map_size
	
	var target_zoom : Vector2 = min(ratios.x, ratios.y) * Vector2.ONE
	
	var move_factor := MOVE_SPEED*dt
	var zoom_factor := ZOOM_SPEED*dt
	set_position(get_position().lerp(target_position, move_factor))
	set_zoom(get_zoom().lerp(target_zoom, zoom_factor))
