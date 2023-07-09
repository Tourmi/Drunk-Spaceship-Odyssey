class_name Fadeout
extends TextureRect

signal fade_ended

var target_color : Color

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func fadeout() -> void:
	mouse_filter = Control.MOUSE_FILTER_PASS
	target_color = self_modulate
	self_modulate.a = 0
	visible = true
	var tween = get_tree().create_tween()
	tween.tween_property(self, "self_modulate", self_modulate, 1)
	tween.tween_property(self, "self_modulate", target_color, 3)
	await tween.finished
	fade_ended.emit()
