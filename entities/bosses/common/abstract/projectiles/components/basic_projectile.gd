extends Node3D
class_name BaseProjectile

@onready var hitbox: Hitbox = %Hitbox
@onready var lifetime_timer: Timer = %LifetimeTimer

@export var lifetime := 15.0

var direction: Vector3
var speed: float
var active: bool = false

signal activated()
signal finished(projectile: BaseProjectile)

func _ready() -> void:
	lifetime_timer.timeout.connect(finish)

func activate(new_direction: Vector3, new_speed: float) -> void:
	direction = new_direction.normalized()
	speed = new_speed
	active = true
	_face_direction()
	visible = true
	process_mode = Node.PROCESS_MODE_INHERIT
	hitbox.set_deferred("monitoring", true)
	hitbox.set_deferred("monitorable", true)
	lifetime_timer.start(lifetime)
	activated.emit()

func deactivate() -> void:
	active = false
	visible = false
	process_mode = Node.PROCESS_MODE_DISABLED
	hitbox.set_deferred("monitoring", false)
	hitbox.set_deferred("monitorable", false)
	
	lifetime_timer.stop()

func finish() -> void:
	if not active:
		return
	finished.emit(self) 

func _face_direction() -> void:
	if direction.is_zero_approx():
		return

	look_at(global_position + direction, Vector3.UP)
