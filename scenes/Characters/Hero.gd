class_name Hero
extends CharacterBody2D

@export var shooter_component : Shooter_Component

@export var speed := 30.0
@export var firerate := 2.0
var curr_timer := firerate

func _process(delta: float) -> void:
	curr_timer -= delta
	if curr_timer <= 0:
		shooter_component.shoot(Vector2(0, -1))
		curr_timer = firerate

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	var directionY := Input.get_axis("ui_up", "ui_down")
	if directionY:
		velocity.y = directionY * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed)

	move_and_slide()
