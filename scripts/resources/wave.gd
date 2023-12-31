class_name Wave
extends Resource

@export var enemy_type : PackedScene
@export var wave_curves : Array[Curve2D]
@export var enemy_count : int
@export var time_between_enemies : float
@export var cooldown : float
@export var wave_icon : Texture2D

@export_category("Difficulty")
@export var time_between_enemies_growth : float
@export var enemy_count_growth := 1.0
