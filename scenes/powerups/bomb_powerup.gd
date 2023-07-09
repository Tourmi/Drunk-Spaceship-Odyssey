class_name BombPickup
extends Powerup

func pickup() -> void:
	Globals.hero.powerup_sound.play()
	Globals.hero.bomb_count += 1
	super.pickup()
