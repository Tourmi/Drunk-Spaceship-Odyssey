class_name Shooter_Component
extends Node2D

@export var bullet_to_spawn : PackedScene
@export var is_hero : bool

@export var damage : int
@export var min_speed : float
@export var max_speed : float
@export_range(0, 1) var random_spread : float
@export var count := 1
@export_range(0, 1) var even_spread : float


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass

func shoot(direction: Vector2) -> void:
	var angle_delta := 0.0
	if even_spread > 0 and count > 1:
		direction = direction.rotated(-PI * even_spread)
		angle_delta = (even_spread / (count - 1)) * TAU

	for i in count:
		if even_spread > 0: direction = direction.rotated(angle_delta)
		_spawn_bullet(direction.rotated(self.global_rotation))

func _spawn_bullet(direction: Vector2) -> void:
	var bullet := bullet_to_spawn.instantiate() as Bullet
	if random_spread > 0: direction = direction.rotated((randf() * random_spread * TAU) - (random_spread * PI))
	bullet.is_hero = self.is_hero
	bullet.position = self.global_position
	bullet.velocity = (direction * (min_speed + (max_speed - min_speed) * randf()))
	bullet.damage = damage
	Globals.bullet_spawn.add_child(bullet)
