class_name PowerPowerup
extends Powerup

@export var damage_amount := 25

func pickup() -> void:
	Globals.hero.powerup_sound.play()
	Globals.hero.shooter_component.damage += damage_amount
	super.pickup()
