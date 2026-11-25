extends Node
class_name DashComponent

@export var player: Player
@export var camera: PhantomCamera3D
@export var player_state: PlayerStateComponent
@onready var camera_focus: Node3D = %CameraFocus

@export_category("Dash")
@export var dash_speed := 30.0
@export var dash_duration := 0.15
@export var dash_cooldown := 0.5
@export var dash_input := "dash"

var is_dashing := false
var can_dash := true

var dash_direction := Vector3.ZERO
var dash_timer := 0.0
var cooldown_timer := 0.0

func _physics_process(delta: float) -> void:
	if cooldown_timer > 0.0:
		cooldown_timer -= delta

	if dash_timer > 0.0:
		dash_timer -= delta

		player.velocity.x = dash_direction.x * dash_speed
		player.velocity.z = dash_direction.z * dash_speed

		if dash_timer <= 0.0:
			is_dashing = false

	if Input.is_action_just_pressed(dash_input):
		try_dash()


func try_dash() -> void:
	if !can_dash:
		return

	if is_dashing:
		return

	var direction := get_dash_direction()

	if direction == Vector3.ZERO:
		return
	
	RotationManager.rotate_towards_target(player.model, camera_focus, 0.2)

	dash_direction = direction
	is_dashing = true
	can_dash = false

	dash_timer = dash_duration
	cooldown_timer = dash_cooldown

	player.velocity.x = dash_direction.x * dash_speed
	player.velocity.z = dash_direction.z * dash_speed

	await get_tree().create_timer(dash_cooldown).timeout
	can_dash = true

func get_dash_direction() -> Vector3:
	return (camera_focus.global_position - player.global_position).normalized()
