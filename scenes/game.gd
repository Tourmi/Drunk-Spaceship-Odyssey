extends Node2D

@onready var line_preview := $LinePreview as Line2D
@onready var spawn_paths := $SpawnPaths as WaveSpawner
@onready var game_bounds := %GameBounds as Area2D
@onready var camera := $Camera2D as Camera
@onready var fadeout := %Fadeout as Fadeout
@onready var music := $music as AudioStreamPlayer2D
@onready var click := $ClickSound as AudioStreamPlayer2D

var line_draw := 0

func _ready() -> void:
	Globals.spawner = spawn_paths
	Globals.bullet_spawn = $Bullets as Node
	Globals.game_bounds = game_bounds
	Globals.camera = camera
	Globals.click = click

var inited := false
var is_fading := false

func _process(delta: float) -> void:
	camera.offset = Vector2()
	inited = Globals.hero != null or inited
	if inited and not is_fading and get_tree().get_nodes_in_group("Hero").size() == 0:
		is_fading = true
		var tween := get_tree().create_tween()
		tween.tween_property(music, "volume_db", -60, 2)
		fadeout.fadeout()
