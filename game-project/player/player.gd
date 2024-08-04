class_name Player extends Node2D

@onready var visuals : ModuleVisuals = $Visuals
@onready var looker : ModuleLooker = $Looker
@onready var lives : ModuleLives = $Lives
@onready var glasses_picker : ModuleGlassesPicker = $GlassesPicker
@onready var stats_tracker : ModuleStatsTracker = $StatsTracker
@onready var ghost_killer : ModuleGhostKiller = $GhostKiller
@export var player_data : PlayerData

func activate() -> void:
	player_data.player = self
	visuals.activate(looker, lives)
	looker.activate()
	lives.activate()
	glasses_picker.activate(looker)
	ghost_killer.activate(stats_tracker, looker)
