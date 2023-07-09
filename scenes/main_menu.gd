extends Control

@onready var tutorial := $TutorialScreens as TextureRect
@onready var next_button := $TutorialScreens/Next as Button
@onready var lore := $TutorialScreens/Lore as Label
@onready var credits := $CreditsControl as Node

var screen_count := 6
var curr_slide := 0
var texture_atlas : AtlasTexture

func _ready() -> void:
	texture_atlas = tutorial.texture as AtlasTexture

func _on_tutorial_pressed() -> void:
	tutorial.visible = true
	curr_slide = 0
	lore.visible = true
	texture_atlas.region.position = Vector2(0, 0)



func _on_next_pressed() -> void:
	lore.visible = false
	curr_slide += 1
	if curr_slide >= screen_count:
		tutorial.visible = false
		texture_atlas.region.position = Vector2(0, 0)
	if curr_slide == 2:
		next_button.position -= Vector2(0, 80)
	if curr_slide == 3:
		next_button.position += Vector2(0, 80)

	texture_atlas.region.position = Vector2(320 * curr_slide, 0)

func _on_credits_pressed() -> void:
	credits.visible = true

func _on_return_pressed() -> void:
	credits.visible = false
