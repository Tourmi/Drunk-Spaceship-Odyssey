class_name Hero
extends CharacterBody2D

signal bombs_changed(old : int, new : int)

const time_ahead := 0.1
const max_dist := 25
const target_dist_from_walls := 20

const RANDOM_DIR_INFLUENCE := 1
const AVOID_BULLETS_INFLUENCE := 20
const AVOID_ENEMIES_INFLUENCE := 15
const AVOID_WALLS_INFLUENCE := 8
const POWERUP_INFLUENCE := 10

@export var bomb_cooldown := 3.0
@export var min_bullet_distance := 100
@export var speed := 30.0
@export var firerate := 2.0
@export var bomb_count : int : set = _set_bombs
@export var explosion_scene : PackedScene
var curr_timer := firerate

var target_direction := Vector2(0, -1)
var wanted_direction := Vector2(0, -1)
var curr_bomb_cooldown : float

@onready var shooter_component := $Shooter_Component as Shooter_Component
@onready var health_component := $Health_Component as Health_Component
@onready var fuel_component := $FuelComponent as FuelComponent
@onready var avoid_area := $AvoidanceArea as Area2D
@onready var panic_area := $PanicArea as Area2D

func _ready() -> void:
	bomb_count = 1
	Globals.hero = self

func _process(delta: float) -> void:
	curr_timer -= delta
	curr_bomb_cooldown -= delta
	if curr_timer <= 0:
		shooter_component.shoot(Vector2(0, -1))
		curr_timer = firerate
	if wanted_direction.is_zero_approx(): wanted_direction = Vector2(0, -1)

	var calc := _get_random_direction() * RANDOM_DIR_INFLUENCE
	calc += _get_avoid_bullets_direction() * AVOID_BULLETS_INFLUENCE
	calc += _get_avoid_enemies_direction() * AVOID_ENEMIES_INFLUENCE
	calc += _get_avoid_walls_direction() * AVOID_WALLS_INFLUENCE
	calc += _get_direction_to_powerup() * POWERUP_INFLUENCE

	wanted_direction = (wanted_direction * 2 + calc.normalized()).normalized()

	self.rotation = (self.rotation * 7 -(wanted_direction + Vector2(0, -1.2)).angle_to(Vector2(0, -1))) / 8
	if _should_use_bomb():
		var bomb := explosion_scene.instantiate() as BombExplosion
		bomb.position = self.position
		Globals.bullet_spawn.add_child(bomb)
		_set_bombs(bomb_count - 1)
		curr_bomb_cooldown = bomb_cooldown

func _physics_process(delta: float) -> void:
	velocity = wanted_direction * speed
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Bullet and not (body as Bullet).is_hero:
		var bullet := body as Bullet
		health_component.current_health -= bullet.damage
		bullet.queue_free()
	if body is Powerup:
		var powerup := body as Powerup
		powerup.pickup()


func _get_random_direction() -> Vector2:
	return (wanted_direction.rotated(randf() * TAU / 8 - TAU / 16)).normalized()

func _get_avoid_bullets_direction() -> Vector2:
	var result := Vector2()
	var nodes = avoid_area.get_overlapping_bodies()
	for node in nodes:
		if not node is Bullet: continue
		var bullet := node as Bullet
		if bullet.is_hero: continue
		var will_be := bullet.position + bullet.velocity * time_ahead
		result += _get_away_point(will_be)
	return result.normalized()

func _get_avoid_enemies_direction() -> Vector2:
	var result := Vector2()
	var nodes = avoid_area.get_overlapping_areas()
	for node in nodes:
		if not node.get_parent() is Enemy: continue
		var enemy := node.get_parent() as Enemy
		result += _get_away_point(enemy.position)

	return result.normalized()

func _get_away_point(other : Vector2) -> Vector2:
	var away := self.position - other
	var dist := pow(max_dist - away.length(), 2)
	return away.normalized() * dist

func _get_avoid_walls_direction() -> Vector2:
	var result := Vector2()
	var dist_left := self.position.x - 100
	result += Vector2(pow(max(target_dist_from_walls - dist_left, 0), 2), 0)
	var dist_right := 220 - self.position.x
	result -= Vector2(pow(max(target_dist_from_walls - dist_right, 0), 2), 0)
	var dist_up := self.position.y - 50
	result += Vector2(0, pow(max(target_dist_from_walls - dist_up, 0), 2))
	var dist_down := 180 - self.position.y
	result -= Vector2(0, pow(max(target_dist_from_walls - dist_down, 0), 2))

	return result.normalized()

func _get_direction_to_powerup() -> Vector2:
	var min_dist := INF
	var curr_powerup : Powerup = null
	for p in get_tree().get_nodes_in_group("Powerup"):
		var powerup := p as Powerup
		if _should_ignore_powerup(powerup): continue
		var dist := position.distance_squared_to(powerup.global_position)
		if dist < min_dist:
			curr_powerup = powerup
			min_dist = dist
	if curr_powerup == null: return Vector2()

	return position.direction_to(curr_powerup.global_position)

func _should_ignore_powerup(powerup : Powerup) -> bool:
	if powerup is HealthPickup:
		if float(health_component.current_health) / health_component.max_health >= 0.75: return true
	if powerup is FuelPickup:
		if float(fuel_component.current_fuel) / fuel_component.max_fuel >= 0.75: return true
	return false

func _set_bombs(amount : int) -> void:
	bombs_changed.emit(bomb_count, amount)
	bomb_count = amount

func _should_use_bomb() -> bool:
	if bomb_count <= 0: return false
	if curr_bomb_cooldown > 0: return false
	var nodes = panic_area.get_overlapping_bodies()
	for node in nodes:
		if node is Bullet and not (node as Bullet).is_hero:
			return true

	nodes = panic_area.get_overlapping_areas()
	for node in nodes:
		if node.get_parent() is Enemy: return true

	return false


func _on_health_component_health_changed(new_amount : int, old_amount : int) -> void:
	if old_amount - new_amount < 10: return
	Globals.camera.shake(1, 0.25)


func _on_health_component_health_empty() -> void:
	Globals.camera.shake(4, 0.5)
