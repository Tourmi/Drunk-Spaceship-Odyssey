class_name Shooter_Component
extends Node2D

@export var bullet_to_spawn : PackedScene
@export var is_hero : bool

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass

func shoot(direction: Vector2) -> void:
	var bullet = bullet_to_spawn.instantiate() as Bullet
	bullet.is_hero = self.is_hero
	bullet.position = self.global_position
	bullet.velocity = direction * bullet.speed
	Globals.bullet_spawn.add_child(bullet)
