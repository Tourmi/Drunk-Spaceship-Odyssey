@tool
extends Button

@export var enemyToSpawn : PackedScene

func _ready() -> void:
	var enemy = enemyToSpawn.instantiate() as Enemy
	self.set_text(enemy.enemy_name)
	pass

func _on_pressed() -> void:
	if Globals.spawn_path == null: return
	var enemy = enemyToSpawn.instantiate() as Enemy
	Globals.spawn_path.add_child(enemy)
