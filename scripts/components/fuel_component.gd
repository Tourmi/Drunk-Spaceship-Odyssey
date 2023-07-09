class_name FuelComponent
extends Node

signal max_fuel_changed(new: int, old: int)
signal fuel_changed(new: int, old: int)

@export var health_component : Health_Component

@export var max_fuel : int : set = _set_max_fuel
@export var current_fuel : int : set = _set_fuel
@export var base_drain : float
@export var drain_growth : float
@export var health_drain_multiplier : float
@export var fuel_up_sound : AudioStreamPlayer2D
@export var out_of_fuel : AudioStreamPlayer2D

var curr_drained : float
var curr_health_drain : float


func _process(delta: float) -> void:
	curr_drained += (base_drain * (1 + drain_growth * Globals.get_difficulty())) * delta
	var total_drain := floori(curr_drained)
	var fuel_drain := mini(total_drain, current_fuel)
	var curr_health_drain := maxf(total_drain - fuel_drain, 0) * health_drain_multiplier
	curr_drained -= fuel_drain
	current_fuel -= fuel_drain
	if curr_health_drain > 1:
		health_component.current_health -= curr_health_drain
		curr_drained -= floori(curr_health_drain) / health_drain_multiplier
		curr_health_drain -= floori(curr_health_drain)

func _set_max_fuel(value : int) -> void:
	if value == max_fuel: return
	max_fuel_changed.emit(value, max_fuel)
	var old := max_fuel
	max_fuel = value
	current_fuel += value - old

func _set_fuel(value : int) -> void:
	var new := clampi(value, 0, max_fuel)
	if new == current_fuel: return
	if new > current_fuel and fuel_up_sound != null: fuel_up_sound.play()
	fuel_changed.emit(new, current_fuel)
	current_fuel = new

	if out_of_fuel == null: return
	if current_fuel == 0 and not out_of_fuel.playing: out_of_fuel.play()
	if current_fuel > 0 and out_of_fuel.playing: out_of_fuel.stop()
