extends Node3D
class_name BaseProjectile

var direction: Vector3
var speed: float
var active: bool = false

func activate(new_direction: Vector3, new_speed: float) -> void:
	direction = new_direction
	speed = new_speed
	active = true

func _physics_process(delta: float) -> void:
	if not active:
		return

	global_position += direction * speed * delta
