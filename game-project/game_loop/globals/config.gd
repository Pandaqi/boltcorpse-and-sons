class_name Config extends Resource

#
# DEBUG
#
@export var debug_skip_pregame := true
@export var debug_skip_tutorials := false
@export var debug_force_glasses : Array[GlassesTypeData] = []
@export var debug_force_ghosts : Array[GhostTypeData] = []
@export var debug_no_darkness := false
@export var debug_no_damage := false

#
# MAP/CAMERA
#
@export var display_sight_radius := true
@export var display_kill_radius := true
@export var camera_min_multiple_of_def_range_see := 2.5

#
# GLASSES
#
@export var glasses_def_range_kill := 512*3.25
@export var glasses_def_range_see := 512*3.75
@export var glasses_def_damage := 350.0

#
# GHOSTS
#
@export var ghosts_def_health := 1000.0
@export var ghosts_def_shield := 200.0
@export var ghosts_def_range_attack := 128.0
@export var ghosts_def_speed := 120.0
@export var ghosts_max_weaknesses := 3

#
# PROGRESSION
#
@export var prog_max_time := 480.0 # 8 minutes feels like a good maximum time for a level

@export var prog_interval_between_unlocks := 10.0 # this is just the first interval, it ramps up from there
@export var prog_interval_added_per_unlock := 15.0
@export var prog_interval_max := 120
@export var prog_glasses_unlock_first := true # true = the best thing to do for gameplay
@export var prog_include_old_weak_glasses_prob := 0.5 # the probability that ghosts are sensitive for an earlier introduced glass
@export var prog_ghost_perc_to_adopt_new_glasses := 0.5 # the probability that, when new glasses arrive, old ghosts adopt those too

@export var prog_starting_hints_fade_delay := 4.0

#
# SPAWNING
#
@export var min_spawn_dist_to_player := 512*3.0
@export var spawn_bounds_min := { "min": 1.0, "max": 4.0 } # lerped by progression ratio
@export var spawn_bounds_max := { "min": 3.0, "max": 20.0 } # lerped by progression ratio

# @NOTE: at the start of the game, ghosts are easily dealt with, and we want something to DO, so time is short
# Later in the game, you'll already have lots of ghosts, and you lost lives, and you have more glasses to juggle, so let's take more time
@export var spawn_interval_bounds := { "min": 2.0, "max": 5.0 } # lerped by progression ratio

#
# SCORE / STATS
#
@export var score_def_per_unlock := 100.0
@export var score_def_per_ghost_killed := 10.0

#
# LIVES
#
@export var lives_starting_num := 3
@export var lives_max := 9
