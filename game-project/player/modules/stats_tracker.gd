class_name ModuleStatsTracker extends Node

var ghosts_killed : Array[Ghost] = []
var score := 0.0

# @TODO: update the score for random stuff too => bigger ghosts, earlier destroys, more glasses switching/unlocked, etcetera

func killed_ghost(g:Ghost):
	ghosts_killed.append(g)
