extends Node
class_name StatsUIController

@onready var health: HealthComponent = %HealthComponent
@onready var health_bar: ProgressBar = %HealthBar

func _ready() -> void:
	health.resource_changed.connect(_on_health_changed)

func _on_health_changed(update: ResourceUpdate) -> void:
	TweenManager.tween_bar(health_bar, update.current_value)
