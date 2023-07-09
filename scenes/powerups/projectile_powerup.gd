extends Powerup

func pickup() -> void:
	Globals.hero.powerup_sound.play()
	var shoot := Globals.hero.shooter_component
	shoot.count = mini(50, shoot.count + 1)
	shoot.random_spread = maxf(minf(shoot.count * 0.01, 0.45), shoot.random_spread)
	super.pickup()
