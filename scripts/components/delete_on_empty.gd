class_name DeleteOnEmptyComponent
extends Node

@export var minimum_count := 1

func _process(delta: float) -> void:
	if get_parent().get_child_count() <= minimum_count: get_parent().queue_free()
