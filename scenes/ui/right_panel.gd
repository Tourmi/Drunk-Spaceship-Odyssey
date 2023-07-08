@tool
extends PanelContainer

@export var waves : WaveList
@export var spawn_enemy_button_scene : PackedScene
@export var enemy_button_container : Container

@onready var animation_player := $AnimationPlayer as AnimationPlayer

func _ready() -> void:
	for wave_scene in waves.waves:
		var button := spawn_enemy_button_scene.instantiate() as SpawnButton
		button.wave = wave_scene
		enemy_button_container.add_child(button)
	size = Vector2(320, 180)

func _process(delta: float) -> void:
	pass

func _attempt_steam() -> void:
	if randf() > 0.90: animation_player.play("steam")
