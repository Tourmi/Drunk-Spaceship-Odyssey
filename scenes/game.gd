extends Node2D

@onready var line_preview = $LinePreview as Line2D
@onready var spawn_paths = $SpawnPaths as WaveSpawner
@onready var game_bounds = %GameBounds as Area2D
@onready var camera = $Camera2D as Camera

var line_draw := 0

func _ready() -> void:
	Globals.spawner = spawn_paths
	Globals.bullet_spawn = $Bullets as Node
	Globals.game_bounds = game_bounds
	Globals.camera = camera

func _process(delta: float) -> void:
	camera.offset = Vector2()

