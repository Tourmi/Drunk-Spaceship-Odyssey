extends Powerup

@export var fuel_amount := 50

func pickup() -> void:
	Globals.hero.powerup_sound.play()
	Globals.hero.fuel_component.max_fuel += fuel_amount
	super.pickup()
