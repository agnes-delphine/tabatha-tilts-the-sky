extends Node
class_name CameraComponent

@onready var camera_pivot: Node3D = %CameraPivot
@onready var camera: PhantomCamera3D = %PhantomCamera3D
@onready var model: Node3D = %Model
@onready var camera_focus: Node3D = %CameraFocus

@export_category("Mouse Look")
@export var look_distance := 4.0
@export var look_smoothing := 10.0
@export var mouse_deadzone := 0.05

@export_category("Target Follow")
@export var rotation_speed := 18.0
var following_target : Node3D

func _physics_process(delta: float) -> void:
	if is_instance_valid(following_target):
		follow_target(delta, model, following_target)

	var viewport := get_viewport()
	var cam := viewport.get_camera_3d()
	if cam == null:
		return

	var viewport_size := viewport.get_visible_rect().size
	var mouse_position := viewport.get_mouse_position()

	var player_screen_pos := cam.unproject_position(player_position())
	var mouse_offset := mouse_position - player_screen_pos

	var half_size := viewport_size * 0.5
	var normalized_offset := Vector2(
		mouse_offset.x / half_size.x,
		mouse_offset.y / half_size.y
	)

	if normalized_offset.length() < mouse_deadzone:
		normalized_offset = Vector2.ZERO

	normalized_offset = normalized_offset.limit_length(1.0)

	var target_offset := Vector3(
		normalized_offset.x,
		0.0,
		normalized_offset.y
	) * look_distance

	var desired_position := player_position() + target_offset

	camera_focus.global_position = camera_focus.global_position.lerp(
		desired_position,
		1.0 - exp(-look_smoothing * delta)
	)

## Rotates a given node towards another node every frame.
func follow_target(delta: float, follower: Node3D, followed: Node3D, _rotation_speed : float = rotation_speed) -> void:
	var direction := followed.global_position - follower.global_position
	direction.y = 0.0

	if direction.length_squared() <= 0.001:
		return

	direction = direction.normalized()

	var target_rotation := atan2(direction.x, direction.z)

	follower.rotation.y = lerp_angle(
		follower.rotation.y,
		target_rotation,
		_rotation_speed * delta
	)
	
func player_position() -> Vector3:
	return model.global_position

func set_look_at_target(target: Node3D) -> void:
	following_target = target
