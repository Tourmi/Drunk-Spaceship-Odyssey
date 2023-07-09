class_name SpeedPowerup
extends Powerup

@export var speed_amount := 10

func pickup() -> void:
	Globals.hero.powerup_sound.play()
	Globals.hero.speed += speed_amount
	super.pickup()
