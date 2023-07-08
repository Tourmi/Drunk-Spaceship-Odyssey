class_name BombExplosion
extends Node2D

@export var damage := 1000
@export var wave_width : float
@export var initial_radius : float
@export var initial_growth : float
@export var growth_decrease : float
@export var initial_color := Color.FLORAL_WHITE
@export var fade_time := 0.25

@onready var outer_area := $Outer as Area2D

@onready var current_radius := initial_radius
@onready var current_growth := initial_growth

var circle : CircleShape2D

@onready var timeout := fade_time

func _ready() -> void:
	circle = CircleShape2D.new()
	circle.radius = current_radius + wave_width
	outer_area.get_child(0).shape = circle

func _physics_process(delta: float) -> void:
	if current_growth <= 10:
		timeout -= delta
		if timeout <= 0: queue_free()
	current_growth = maxf(0, current_growth - growth_decrease * delta)
	current_radius += current_growth * delta
	circle.radius = current_radius + wave_width / 2
	queue_redraw()
	pass

func _draw() -> void:
	draw_arc(Vector2(), current_radius, 0, TAU, 100, Color(initial_color.r,initial_color.g,initial_color.b, max(0, timeout / fade_time)), wave_width, false)

func _on_outer_body_entered(body: Node2D) -> void:
	if body is Bullet and not (body as Bullet).is_hero:
		body.queue_free()

func _on_outer_area_entered(area: Area2D) -> void:
	if not area.get_parent() is Enemy: return
	var enemy := area.get_parent() as Enemy
	enemy.health_component.current_health -= damage

