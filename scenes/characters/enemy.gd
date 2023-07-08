class_name Enemy
extends PathFollow2D

@export var health_component : Health_Component
@export var enemy_name := "default"
@export var speed := 10.0
@export var look_down := false

@onready var sprite := %Sprite as Sprite2D

func _ready() -> void:
	self.rotates = not look_down
	if look_down: self.rotation = TAU / 4

func _process(delta: float) -> void:
	progress += speed * delta


func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body is Bullet or not (body as Bullet).is_hero:
		return
	var bullet := body as Bullet
	health_component.current_health -= bullet.damage
	body.queue_free()
