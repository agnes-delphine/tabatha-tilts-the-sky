extends Node
class_name ChangeSceneOnDeathComponent

@onready var death_component: DeathComponent = %DeathComponent

@export var scene : PackedScene

func _ready() -> void:
	death_component.death.connect(_on_death)

func _on_death() -> void:
	LoadingManager.load_packed_scene(scene, false)
