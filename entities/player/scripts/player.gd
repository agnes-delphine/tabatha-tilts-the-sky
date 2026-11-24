extends CharacterBody3D
class_name Player

@export var model : Node3D

func _ready() -> void:
	PlayerManager.register(self)
