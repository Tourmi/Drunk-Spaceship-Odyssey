extends Powerup

func pickup() -> void:
	Globals.hero.bomb_count += 1
	super.pickup()
