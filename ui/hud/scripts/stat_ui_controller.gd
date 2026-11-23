extends Node
class_name StatsUIController

@onready var health: HealthComponent = %HealthComponent
@onready var health_bar: ProgressBar = %HealthBar

@onready var stamina: StaminaComponent = %StaminaComponent
@onready var stamina_bar: ProgressBar = %StaminaBar

func _ready() -> void:
	health.resource_changed.connect(_on_health_changed)
	stamina.resource_changed.connect(_on_stamina_changed)
	

func _on_health_changed(update: ResourceUpdate) -> void:
	TweenManager.tween_bar(health_bar, update.current_value)

func _on_stamina_changed(update: ResourceUpdate) -> void:
	TweenManager.tween_bar(stamina_bar, update.current_value)
