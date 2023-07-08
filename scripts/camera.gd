class_name Camera
extends Camera2D

var curr_intensity : int
var curr_duration : float
var next_shake : float

func _process(delta: float) -> void:
	next_shake -= delta
	if curr_duration <= 0 or next_shake > 0: return
	curr_duration -= delta
	offset = Vector2(randi_range(-curr_intensity, curr_intensity), randi_range(-curr_intensity, curr_intensity))
	next_shake = 2.0 /60

func shake(intensity: int, duration : float) -> void:
	curr_intensity = intensity
	curr_duration = duration
