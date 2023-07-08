class_name Enemy
extends PathFollow2D

@export var health_component : Health_Component
@export var shooter_component : Shooter_Component
@export var enemy_name := "default"
@export var speed := 10.0
@export var look_down := false

@export_category("Difficulty")
@export var speed_growth : float
@export var health_growth : float
@export var bullet_speed_growth : float
@export var bullet_count_growth : float
@export var bullet_spread_growth : float
@export var damage_growth : float

@onready var sprite := %Sprite as Sprite2D

func _ready() -> void:
	speed *= 1 + Globals.get_difficulty() * speed_growth
	health_component.max_health *= 1 + Globals.get_difficulty() * health_growth
	shooter_component.min_speed *= 1 + Globals.get_difficulty() * bullet_speed_growth
	shooter_component.max_speed *= 1 + Globals.get_difficulty() * bullet_speed_growth
	shooter_component.count *= 1 + Globals.get_difficulty() * bullet_count_growth
	shooter_component.even_spread *= 1 + Globals.get_difficulty() * bullet_spread_growth
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
