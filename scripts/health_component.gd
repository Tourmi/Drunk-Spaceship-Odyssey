class_name Health_Component
extends Node

signal health_empty

@export var max_health : int
@export var current_health : int : set = _set_health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_health = max_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _set_health(amount : int) -> void:
	current_health = amount
	if current_health <= 0:
		health_empty.emit()