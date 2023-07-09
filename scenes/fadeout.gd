class_name Fadeout
extends TextureRect

signal fade_ended

@onready var restart_button := $Button as Button
@onready var main_menu := $"Main Menu" as Button
@onready var score := $Score as Control

var target_color : Color

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	score.visible = false
	restart_button.visible = false
	main_menu.visible = false
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
	tween.tween_property(self, "self_modulate", self_modulate, 1.0)
	tween.tween_property(self, "self_modulate", target_color, 1.5)
	tween.tween_property(self, "self_modulate", target_color, 0.1)
	await tween.finished
	fade_ended.emit()


func _on_fade_ended() -> void:
	score.visible = true
	main_menu.visible = true
	restart_button.visible = true


func _on_main_menu_pressed() -> void:
	Globals.reset()
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
