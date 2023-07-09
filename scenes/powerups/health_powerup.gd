class_name HealthPowerup
extends Powerup

@export var health_amount := 50

func pickup() -> void:
	Globals.hero.health_component.max_health += health_amount
	super.pickup()
