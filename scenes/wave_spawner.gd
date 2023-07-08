class_name WaveSpawner
extends Node2D

@export var path_scene : PackedScene

func spawn_wave(wave : Wave) -> void:
	var path := path_scene.instantiate() as Path2D
	path.curve = wave.wave_curve
	var temp = Node2D.new()
	path.add_child(temp)
	add_child(path)
	var direction = 1 if randi() % 2 == 0 else -1
	var actual_count = floori(wave.enemy_count * (1 + wave.enemy_count_growth * Globals.get_difficulty()))
	var actual_time = wave.time_between_enemies / (1 + wave.time_between_enemies_growth * Globals.get_difficulty())
	for i in actual_count:
		var enemy = wave.enemy_type.instantiate() as Enemy
		enemy.progress_direction = direction
		path.add_child(enemy)
		await get_tree().create_timer(actual_time).timeout

	path.remove_child(temp)


