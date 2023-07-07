class_name Enemy
extends PathFollow2D

@export var health_component : Health_Component
@export var enemy_name := "default"
@export var speed := 10.0

func _process(delta: float) -> void:
	progress += speed * delta


func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body is Bullet or not (body as Bullet).is_hero:
		return
	body.queue_free()
	health_component.current_health -= 1
