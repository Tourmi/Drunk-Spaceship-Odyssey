extends PanelContainer

@export var bomb_icon : PackedScene

@onready var hero_health := %CurrentHealth as TextureProgressBar
@onready var tween_health := %ProgressHealthBar as TextureProgressBar
@onready var multiplier := %Multiplier as Label
@onready var animation_player := $AnimationPlayer as AnimationPlayer
@onready var bombs_container := %BombsContainer as HFlowContainer

var inited := false

func _process(delta: float) -> void:
	multiplier.text = "Mult:%.2f" % Globals.get_multiplier()
	if Globals.hero == null: return
	hero_health.max_value = Globals.hero.health_component.max_health
	tween_health.max_value = Globals.hero.health_component.max_health
	if inited: return
	hero_health.value = Globals.hero.health_component.current_health
	tween_health.value = Globals.hero.health_component.current_health
	Globals.hero.health_component.health_changed.connect(_on_health_changed)

	Globals.hero.bombs_changed.connect(_on_bombs_changed)
	_on_bombs_changed(0, Globals.hero.bomb_count)
	inited = true

func _on_health_changed(amount : int) -> void:
	hero_health.value = amount
	var tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(tween_health, "value", amount, 1)

func _attempt_steam() -> void:
	if randf() > 0.90:
		animation_player.play("steam")
		await animation_player.animation_finished
		animation_player.play("regular")

func _on_bombs_changed(old : int, new : int) -> void:
	var diff = new - old
	if diff == 0: return
	if diff < 0:
		for i in abs(diff):
			bombs_container.get_child(i).queue_free()
	if diff > 0:
		for i in diff:
			var icon := bomb_icon.instantiate() as Control
			bombs_container.add_child(icon)
