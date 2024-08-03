extends Camera2D

const MOVE_SPEED := 8.0
const ZOOM_SPEED := 8.0
# @NOTE: the generous margin on Y ensures that we get a good zoomed-out view, but also that we have space for the UI above and below
const CAMERA_EDGE_MARGIN := Vector2(32.0, 256.0+48.0)

@export var player_data : PlayerData
@export var config : Config

func _process(dt:float):
	fit_bounds_in_view(dt)

func fit_bounds_in_view(dt:float):
	if not player_data.player: return
	
	# We only care about WIDTH => it should be precisely large enough that our default sight range covers ~2/3 of the screen
	var required_width := config.camera_min_multiple_of_def_range_see * config.glasses_def_range_see
	var target_position := player_data.player.get_position()
	
	var vp_size := get_viewport_rect().size
	var target_zoom := vp_size.x / required_width * Vector2.ONE
	
	var move_factor := MOVE_SPEED*dt
	var zoom_factor := ZOOM_SPEED*dt
	set_position(get_position().lerp(target_position, move_factor))
	set_zoom(get_zoom().lerp(target_zoom, zoom_factor))
