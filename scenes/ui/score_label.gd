extends Label

func _process(delta: float) -> void:
	text = "Score\n%d" % Globals.score
	pass
