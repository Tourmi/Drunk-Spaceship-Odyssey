class_name Hero
extends CharacterBody2D

const time_ahead = 0.25
const max_dist = 20
const target_dist_from_walls = 20

@export var speed := 30.0
@export var firerate := 2.0
var curr_timer := firerate

var wanted_direction := Vector2(0, 0)

@onready var shooter_component := $Shooter_Component as Shooter_Component
@onready var health_component := $Health_Component as Health_Component
@onready var avoid_area := $AvoidanceArea as Area2D

func _process(delta: float) -> void:
	curr_timer -= delta
	if curr_timer <= 0:
		shooter_component.shoot(Vector2(0, -1))
		curr_timer = firerate


	var nodes = avoid_area.get_overlapping_bodies()
	for node in nodes:
		if not node is Bullet: continue
		var bullet = node as Bullet
		if bullet.is_hero: continue
		var will_be = bullet.position + bullet.velocity * time_ahead
		var away = self.position - will_be
		var dist = pow(max_dist - away.length(), 2)
		wanted_direction += away .normalized() * dist

	var dist_left = self.position.x - 100
	wanted_direction += Vector2(pow(max(target_dist_from_walls - dist_left, 0), 2), 0)
	var dist_right = 220 - self.position.x
	wanted_direction -= Vector2(pow(max(target_dist_from_walls - dist_right, 0), 2), 0)
	var dist_up = self.position.y
	wanted_direction += Vector2(0, pow(max(target_dist_from_walls - dist_up, 0), 2))
	var dist_down = 180 - self.position.y
	wanted_direction -= Vector2(0, pow(max(target_dist_from_walls - dist_down, 0), 2))



	wanted_direction = wanted_direction.normalized()



func _physics_process(delta: float) -> void:
	velocity = wanted_direction * speed
	wanted_direction = Vector2()

#	var direction := Input.get_axis("ui_left", "ui_right")
#	if direction:
#		velocity.x = direction * speed
#	else:
#		velocity.x = move_toward(velocity.x, 0, speed)
#	var directionY := Input.get_axis("ui_up", "ui_down")
#	if directionY:
#		velocity.y = directionY * speed
#	else:
#		velocity.y = move_toward(velocity.y, 0, speed)

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body is Bullet or (body as Bullet).is_hero:
		return
	body.queue_free()
	health_component.current_health -= 1
