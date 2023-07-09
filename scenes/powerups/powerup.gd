class_name Powerup
extends CharacterBody2D

@export var initial_speed := Vector2(0, 8)

var target_speed

func _ready() -> void:
	if position.x < 105: position.x = 105
	if position.x > 215: position.x = 215
	velocity = initial_speed

func _physics_process(delta: float) -> void:
	move_and_slide()

func pickup() -> void:
	queue_free()
