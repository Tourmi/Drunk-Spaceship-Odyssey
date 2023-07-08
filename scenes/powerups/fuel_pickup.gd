class_name FuelPickup
extends Powerup

@export var fuel_amount := 500

func pickup() -> void:
	Globals.hero.fuel_component.current_fuel += fuel_amount
	super.pickup()
