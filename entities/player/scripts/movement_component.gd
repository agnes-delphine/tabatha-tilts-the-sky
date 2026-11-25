extends Node
class_name MovementComponent

@export var player: CharacterBody3D
@export var camera: PhantomCamera3D
@export var model: Node3D
@export var player_state: PlayerStateComponent
@export var speed_modifier: MovementSpeedModifierComponent
@export var attacker_state : AttackerStateComponent

@export_category("Movement")
@export var base_speed := 20.0
@export var acceleration := 70.0
@export var deceleration := 100.0

var current_speed : float

@export_category("Rotation")
@export var rotation_lerp_speed := 0.25

func _ready() -> void:
	current_speed = base_speed
	speed_modifier.movement_speed_modifiers_updated.connect(_on_movement_speed_modifiers_updated)

func _on_movement_speed_modifiers_updated(modifiers: Dictionary) -> void:
	current_speed = base_speed
	if modifiers.is_empty():
		return
	
	var total_modifier := 0.0
	for modifier in modifiers.values():
		total_modifier += modifier
	
	current_speed = base_speed * total_modifier
	
func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	
	if player_state.is_state(
		PlayerStateComponent.PlayerState.IDLE
	):
		get_move_input(delta)

	player.move_and_slide()

func get_move_input(delta: float) -> void:
	var input := Input.get_vector(
		"move_left",
		"move_right",
		"move_forward",
		"move_backwards"
	)

	var dir := Vector3.ZERO

	if input.length_squared() > 0.01:
		var forward := camera.global_transform.basis.z
		var right := camera.global_transform.basis.x

		forward.y = 0.0
		right.y = 0.0

		forward = forward.normalized()
		right = right.normalized()

		dir = (forward * input.y + right * input.x).normalized()

		var target_yaw := atan2(dir.x, dir.z)

		## Model follows the cursor if charging attack
		if !attacker_state.is_state(attacker_state.AttackerState.ATTACKING):
			model.rotation.y = lerp_angle(
				model.rotation.y,
				target_yaw,
				1.0 - exp(-10.0 * delta)
			)

	var horizontal_velocity := Vector3(
		player.velocity.x,
		0.0,
		player.velocity.z
	)

	if player.is_on_floor():
		var target_velocity := dir * current_speed

		var rate := (
			acceleration
			if dir != Vector3.ZERO
			else deceleration
		)

		horizontal_velocity.x = move_toward(
			horizontal_velocity.x,
			target_velocity.x,
			rate * delta
		)

		horizontal_velocity.z = move_toward(
			horizontal_velocity.z,
			target_velocity.z,
			rate * delta
		)

	player.velocity.x = horizontal_velocity.x
	player.velocity.z = horizontal_velocity.z


func apply_gravity(delta: float) -> void:
	var gravity = player.get_gravity()
	if !player.is_on_floor():
		player.velocity += gravity * delta
