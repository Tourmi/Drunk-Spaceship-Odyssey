class_name Camera
extends Camera2D

var curr_intensity : int
var curr_duration : float

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if curr_duration <= 0: return
	curr_duration -= delta
	offset = Vector2(randi_range(-curr_intensity, curr_intensity), randi_range(-curr_intensity, curr_intensity))

func shake(intensity: int, duration : float) -> void:
	curr_intensity = intensity
	curr_duration = duration
