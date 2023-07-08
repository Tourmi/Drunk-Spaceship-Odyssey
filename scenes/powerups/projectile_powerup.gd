extends Powerup

func pickup() -> void:
	var shoot := Globals.hero.shooter_component
	shoot.count += 1
	shoot.random_spread = maxf(minf(shoot.count * 0.01, 0.45), shoot.random_spread)
	super.pickup()
