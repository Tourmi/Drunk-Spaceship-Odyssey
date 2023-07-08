extends Node2D

@export var enemies : EnemyList
@export var paths : PathList

@onready var line_preview = $LinePreview as Line2D
@onready var spawn_paths = $SpawnPaths as Node2D

var line_draw := 0

func _ready() -> void:
	for path in paths.path_list:
		var new_path = Path2D.new()
		new_path.curve = path
		spawn_paths.add_child(new_path)

	Globals.spawn_path = spawn_paths.get_children()[0]
	Globals.bullet_spawn = $Bullets as Node

func _process(delta: float) -> void:
	if Globals.spawn_path == null: return

	line_preview.points = Globals.spawn_path.curve.get_baked_points()
