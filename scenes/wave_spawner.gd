class_name WaveSpawner
extends Node2D

func spawn_wave(wave : Wave) -> void:
	var path := Path2D.new()
	path.curve = wave.wave_curve
	add_child(path)

	for i in wave.enemy_count:
		var enemy = wave.enemy_type.instantiate() as Enemy
		path.add_child(enemy)
		await get_tree().create_timer(wave.time_between_enemies).timeout


