extends Button


func _on_toggled(button_pressed: bool) -> void:
	AudioServer.set_bus_mute(0, button_pressed)

