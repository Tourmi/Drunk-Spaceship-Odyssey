extends Node2D

func _ready() -> void:
	Globals.spawn_path = $TempSpawnPath as Path2D
	Globals.bullet_spawn = $Bullets as Node
