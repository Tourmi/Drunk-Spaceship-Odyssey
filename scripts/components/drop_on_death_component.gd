class_name DropOnDeathComponent
extends Node2D

@export var is_guaranteed : bool
@export var is_picked : bool
@export_range(1,100) var base_odds_numerator := 5
@export_range(1,100) var base_odds_denominator := 100

@export var to_spawn : Array[PackedScene] = []
@export var health_component : Health_Component

func _ready() -> void:
	health_component.health_empty.connect(_on_health_expired)

func _on_health_expired() -> void:
	if to_spawn.size() == 0: return
	var odds := base_odds_numerator / float(base_odds_denominator)
	if not is_guaranteed and randf() >= odds:
		return
	if is_picked: _spawn_entity(to_spawn[randi() % to_spawn.size()])
	else: for entity in to_spawn: _spawn_entity(entity)

func _spawn_entity(entity : PackedScene) -> void:
	if entity == null: return
	var instance := entity.instantiate() as Node2D
	instance.position = self.global_position
	call_deferred("_add_instance", instance)

func _add_instance(instance : Node2D) -> void:
	Globals.bullet_spawn.add_child(instance)
