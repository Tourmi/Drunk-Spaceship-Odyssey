class_name HealthPickup
extends Powerup

@export var heal_amount := 100

func pickup() -> void:
	Globals.hero.health_component.current_health += heal_amount
	super.pickup()
