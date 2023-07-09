extends Button

func _on_toggled(button_pressed: bool) -> void:
	AudioServer.set_bus_mute(1, button_pressed)
