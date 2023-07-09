class_name SpawnButton
extends Button

@export var wave : Wave

@onready var progress := $TextureProgressBar as TextureProgressBar

var curr_cooldown : float

func _ready() -> void:
	icon = wave.wave_icon
	progress.value = maxi(0, curr_cooldown * 100)
	progress.visible = false

func _process(delta: float) -> void:
	curr_cooldown -= delta
	progress.value = ceili(curr_cooldown * 100)
	if curr_cooldown <= 0:
		disabled = false
		progress.visible = false

func _on_pressed() -> void:
	if Globals.spawner == null: return
	Globals.spawner.spawn_wave(wave)
	curr_cooldown = wave.cooldown
	progress.max_value = curr_cooldown * 100
	progress.value = curr_cooldown * 100
	disabled = true
	progress.visible = true

