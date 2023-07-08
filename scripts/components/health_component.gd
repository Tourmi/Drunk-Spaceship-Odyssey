class_name Health_Component
extends Node

signal health_empty
signal health_changed(new_amount : int, old_amount : int)
signal maximum_health_changed(new_amount : int, old_amount : int)

@export var max_health : int : set = _set_max_health
@export var current_health : int : set = _set_health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_health = max_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _set_health(amount : int) -> void:
	var old := current_health
	current_health = clampi(amount, 0, max_health)
	if old == current_health: return

	health_changed.emit(current_health, old)
	if current_health <= 0:
		health_empty.emit()

func _set_max_health(amount : int) -> void:
	maximum_health_changed.emit(amount, max_health)
	var upgrade_amount := maxi(amount - max_health, 0)
	max_health = amount
	_set_health(current_health + upgrade_amount)
