extends Button

func _on_pressed() -> void:
	Globals.click.play()
	await Globals.click.finished
	Globals.reset()
	get_tree().change_scene_to_file("res://scenes/game.tscn")
