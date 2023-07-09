extends Node

var spawner : WaveSpawner
var bullet_spawn : Node
var hero : Hero
var game_bounds : Area2D
var camera : Camera

var score = 0
var difficulty := 1.0

func _process(delta: float) -> void:
	difficulty += 0.01 * delta

func reset() -> void:
	score = 0
	difficulty = 1.0

func get_multiplier() -> float:
	return ((spawner.get_child_count() / 10.0) + 1) * difficulty

func get_difficulty() -> float:
	return difficulty - 1
