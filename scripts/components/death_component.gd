class_name DeathComponent
extends Node

@export var health_component : Health_Component

func _ready() -> void:
	health_component.health_empty.connect(_on_death)

func _on_death() -> void:
	get_parent().queue_free()
