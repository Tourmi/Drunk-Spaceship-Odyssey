extends Node2D

@onready var line_preview = $LinePreview as Line2D
@onready var spawn_paths = $SpawnPaths as WaveSpawner

var line_draw := 0

func _ready() -> void:
	Globals.spawner = spawn_paths
	Globals.bullet_spawn = $Bullets as Node

