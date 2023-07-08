class_name DeleteAfterTimeComponent
extends Node

@export var timeout : float

var curr_time := 0.0

func _process(delta: float) -> void:
	curr_time += delta
	if curr_time >= timeout:
		get_parent().queue_free()
