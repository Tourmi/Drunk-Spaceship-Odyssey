class_name Enemy_AI_Component
extends Node

@export var firerate : float
@onready var curr_timer := randf() * firerate

@export var shooter_component : Shooter_Component

func _process(delta: float) -> void:
	curr_timer -= delta
	if curr_timer <= 0:
		shooter_component.shoot(Vector2(0, 1))
		curr_timer = firerate
