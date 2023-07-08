extends PanelContainer

@onready var hero_health := %HealthBar as TextureProgressBar

var inited := false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.hero == null: return
	hero_health.max_value = Globals.hero.health_component.max_health
	if inited: return
	hero_health.value = Globals.hero.health_component.current_health
	Globals.hero.health_component.health_changed.connect(_on_health_changed)
	inited = true

func _on_health_changed(amount : int) -> void:
	var tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(hero_health, "value", amount, 1)
