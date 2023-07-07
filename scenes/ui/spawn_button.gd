@tool
extends Button

@export var enemyToSpawn : PackedScene

func _ready() -> void:
	var enemy = enemyToSpawn.instantiate() as Enemy
	self.set_text(enemy.enemyName)
	pass

func _on_pressed() -> void:
	var enemy = enemyToSpawn.instantiate() as Enemy

	Globals.spawnPath.add_child(enemy)
