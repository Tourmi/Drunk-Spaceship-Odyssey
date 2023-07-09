class_name FireratePowerup
extends Powerup

@export var firerate_mult := 0.95

func pickup() -> void:
	Globals.hero.powerup_sound.play()
	Globals.hero.firerate = maxf(0.05, Globals.hero.firerate * firerate_mult)
	super.pickup()
