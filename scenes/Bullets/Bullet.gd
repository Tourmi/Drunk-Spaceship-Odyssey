class_name Bullet
extends CharacterBody2D

var damage : int

var is_hero := false

func _physics_process(delta: float) -> void:
	move_and_slide()
