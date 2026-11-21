extends Node3D
class_name BaseProjectile

@onready var lifetime_timer: Timer = %LifetimeTimer

@export var lifetime := 15.0

var direction: Vector3
var speed: float
var active: bool = false

func activate(new_direction: Vector3, new_speed: float) -> void:
	direction = new_direction
	speed = new_speed
	active = true
	
	lifetime_timer.start(lifetime)
	await lifetime_timer.timeout
	queue_free()

func _physics_process(delta: float) -> void:
	if not active:
		return

	global_position += direction * speed * delta
