extends PanelContainer

@onready var hero_health := %HeroHealth as Label

var inited := false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if inited or Globals.hero == null: return

	hero_health.text = "Life:%d" % [Globals.hero.health_component.current_health]
	Globals.hero.health_component.health_changed.connect(_on_health_changed)
	inited = true

func _on_health_changed(amount : int) -> void:
	hero_health.text = "Life:%d" % [amount]
