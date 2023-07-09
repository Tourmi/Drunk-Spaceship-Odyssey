class_name FireratePowerup
extends Powerup

@export var firerate_mult := 0.9

func pickup() -> void:
	Globals.hero.powerup_sound.play()
	Globals.hero.firerate = maxf(0.02, Globals.hero.firerate * firerate_mult)
	super.pickup()
