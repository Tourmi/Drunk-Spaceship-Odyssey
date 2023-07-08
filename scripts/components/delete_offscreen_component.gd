class_name DeleteOffscreenComponent
extends Area2D

func _ready() -> void:
	set_collision_mask_value(6, true)
	set_collision_layer_value(6, true)

var outside_screen_count := 0

func _process(delta: float) -> void:
	if not Globals.game_bounds.overlaps_area(self):
		outside_screen_count += 1
	if outside_screen_count >= 3:
		get_parent().queue_free()
