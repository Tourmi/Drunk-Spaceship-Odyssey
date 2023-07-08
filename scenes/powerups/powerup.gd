class_name Powerup
extends CharacterBody2D

@export var initial_speed := Vector2(0, 5)

func _ready() -> void:
	velocity = initial_speed

func _process(delta: float) -> void:
	move_and_slide()

func pickup() -> void:
	queue_free()
