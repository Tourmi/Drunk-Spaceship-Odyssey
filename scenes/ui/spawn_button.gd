@tool
class_name SpawnButton
extends Button

@export var wave : Wave

var curr_cooldown : float

func _ready() -> void:
	icon = wave.wave_icon

func _process(delta: float) -> void:
	curr_cooldown -= delta
	if curr_cooldown <= 0:
		disabled = false

func _on_pressed() -> void:
	if Globals.spawner == null: return
	Globals.spawner.spawn_wave(wave)
	curr_cooldown = wave.cooldown
	disabled = true

