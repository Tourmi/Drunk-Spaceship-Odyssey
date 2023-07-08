class_name Hero
extends CharacterBody2D

const time_ahead := 0.1
const max_dist := 25
const target_dist_from_walls := 20

const RANDOM_DIR_INFLUENCE := 1
const AVOID_BULLETS_INFLUENCE := 10
const AVOID_WALLS_INFLUENCE := 2

@export var speed := 30.0
@export var firerate := 2.0
var curr_timer := firerate

var target_direction := Vector2(0, -1)
var wanted_direction := Vector2(0, -1)

@onready var shooter_component := $Shooter_Component as Shooter_Component
@onready var health_component := $Health_Component as Health_Component
@onready var avoid_area := $AvoidanceArea as Area2D

func _ready() -> void:
	Globals.hero = self

func _process(delta: float) -> void:
	curr_timer -= delta
	if curr_timer <= 0:
		shooter_component.shoot(Vector2(0, -1))
		curr_timer = firerate
	if wanted_direction.is_zero_approx(): wanted_direction = Vector2(0, -1)

	var calc := _get_random_direction() * RANDOM_DIR_INFLUENCE
	calc += _get_avoid_bullets_direction() * AVOID_BULLETS_INFLUENCE
	calc += _get_avoid_walls_direction() * AVOID_WALLS_INFLUENCE

	wanted_direction = (wanted_direction * 2 + calc.normalized()).normalized()

	self.rotation = (self.rotation * 7 -(wanted_direction + Vector2(0, -1.2)).angle_to(Vector2(0, -1))) / 8


func _physics_process(delta: float) -> void:
	velocity = wanted_direction * speed
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body is Bullet or (body as Bullet).is_hero:
		return
	var bullet := body as Bullet
	health_component.current_health -= bullet.damage
	bullet.queue_free()


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
		var away := self.position - will_be
		var dist := pow(max_dist - away.length(), 2)
		result += away.normalized() * dist
	return result.normalized()

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
