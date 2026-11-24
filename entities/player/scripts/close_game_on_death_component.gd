extends Node
class_name CloseGameOnDeathComponent

@onready var death: DeathComponent = %DeathComponent

func _ready() -> void:
	death.death.connect(_on_death)

func _on_death() -> void:
	get_tree().quit()
