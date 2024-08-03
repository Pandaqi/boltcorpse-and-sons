class_name Config extends Resource

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
@export var glasses_def_damage := 35.0

#
# GHOSTS
#
@export var ghosts_def_health := 100.0
@export var ghosts_def_range_attack := 128.0
@export var ghosts_def_speed := 100.0
@export var ghosts_max_weaknesses := 4

#
# PROGRESSION
#
@export var prog_max_time := 600.0

@export var prog_interval_between_unlocks := 10.0
@export var prog_interval_added_per_unlock := 10.0
@export var prog_interval_max := 60
@export var prog_glasses_unlock_first := true # true = the best thing to do for gameplay
@export var prog_include_old_weak_glasses_prob := 0.5 # the probability that ghosts are sensitive for an earlier introduced glass
@export var prog_ghost_perc_to_adopt_new_glasses := 0.5 # the probability that, when new glasses arrive, old ghosts adopt those too

@export var prog_starting_hints_fade_delay := 4.0

#
# SPAWNING
#
@export var min_spawn_dist_to_player := 512*3.0

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
