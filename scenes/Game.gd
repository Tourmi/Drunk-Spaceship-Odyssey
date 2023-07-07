extends Node2D

@export var enemies : EnemyList
@export var paths : PathList

@onready var line_preview = $LinePreview as Line2D
@onready var spawn_path = $SpawnPath as Path2D

var line_draw := 0

func _ready() -> void:
	spawn_path.curve = paths.path_list[0]

	Globals.spawn_path = spawn_path
	Globals.bullet_spawn = $Bullets as Node

func _process(delta: float) -> void:
	if Globals.spawn_path == null: return

	line_preview.points = Globals.spawn_path.curve.get_baked_points()
