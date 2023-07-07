class_name Enemy
extends PathFollow2D

@export var enemyName := "default"
@export var speed := 10.0

func _process(delta: float) -> void:
	progress += speed * delta
