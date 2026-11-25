extends Node3D
class_name ActionPivot

@onready var camera_focus: Node3D = %CameraFocus
@onready var camera: CameraComponent = %CameraComponent

func _physics_process(delta: float) -> void:
	camera.follow_target(delta, self, camera_focus)
