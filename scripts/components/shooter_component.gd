class_name Shooter_Component
extends Node2D

@export var bullet_to_spawn : PackedScene

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass

func shoot(direction: Vector2) -> void:
	var bullet = bullet_to_spawn.instantiate() as CharacterBody2D
	bullet.position = self.global_position
	bullet.velocity = direction * bullet.speed
	get_tree().root.add_child(bullet)
