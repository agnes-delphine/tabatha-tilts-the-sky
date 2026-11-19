extends Node
class_name AttackerComponent

@onready var camera_component: CameraComponent = %CameraComponent
@onready var attack_collider: CollisionShape3D = %AttackCollider
@onready var attack_active_timer: Timer = %AttackActiveTimer
@onready var attacker_state: AttackerStateComponent = %AttackerStateComponent

@onready var camera_focus: Node3D = %CameraFocus
@onready var target_lock_camera_focus: Node3D = %TargetLockCameraFocus

func _ready() -> void:
	attack_collider.disabled = true
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("swing_blade"):
		if attacker_state.is_state(attacker_state.AttackerState.IDLE):
			return
		attack_collider.disabled = false
		attack_active_timer.start()
		await attack_active_timer.timeout
		attack_collider.disabled = true
	
	if event.is_action_pressed("ready_blade"):
		attacker_state.set_state(attacker_state.AttackerState.READY)
		camera_component.set_look_at_target(camera_focus)
	elif event.is_action_released("ready_blade"):
		attacker_state.set_state(attacker_state.AttackerState.IDLE)
		camera_component.set_look_at_target(null)
