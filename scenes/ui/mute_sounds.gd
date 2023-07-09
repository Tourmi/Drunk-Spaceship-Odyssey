extends Button


func _on_toggled(button_pressed: bool) -> void:
	Globals.click.play()
	AudioServer.set_bus_mute(0, button_pressed)

