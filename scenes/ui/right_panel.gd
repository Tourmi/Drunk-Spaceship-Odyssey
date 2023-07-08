@tool
extends PanelContainer

@export var enemy_list : EnemyList
@export var path_list : PathList

@export var spawn_enemy_button_scene : PackedScene

@export var enemy_button_container : Container

func _ready() -> void:
	for enemy_scene in enemy_list.enemies:
		var button := spawn_enemy_button_scene.instantiate() as SpawnButton
		button.enemyToSpawn = enemy_scene
		enemy_button_container.add_child(button)


