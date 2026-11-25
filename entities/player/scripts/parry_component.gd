extends Node
class_name ParryComponent

@onready var parry_hitbox: ParryHitbox = %ParryHitbox
@onready var parry_active_timer: Timer = %ParryActiveTimer
@onready var model: Node3D = %Model
@onready var camera_focus: Node3D = %CameraFocus
@onready var attacker_charge: AttackerChargeComponent = %AttackerChargeComponent

func _ready() -> void:
	parry_hitbox.set_collider_state(false)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("parry"):
		parry()

func parry() -> void:
	parry_hitbox.set_collider_state(true)
	parry_active_timer.start()
	await parry_active_timer.timeout
	parry_hitbox.set_collider_state(false)
	
	RotationManager.rotate_towards_target(model, camera_focus, 0)
