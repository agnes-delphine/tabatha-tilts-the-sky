extends Node
class_name AttackerComponent

@onready var model: Node3D = %Model

@onready var camera_component: CameraComponent = %CameraComponent
@onready var camera_focus: Node3D = %CameraFocus

@onready var attack_hitbox: Hitbox = %AttackHitbox
@onready var attack_active_timer: Timer = %AttackActiveTimer

@onready var attacker_state: AttackerStateComponent = %AttackerStateComponent
@onready var attacker_charge: AttackerChargeComponent = %AttackerChargeComponent

var charge_at_release := 0.0
var attacking := false

signal player_attacked()

func _ready() -> void:
	attack_hitbox.set_collider_state(false)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		if attacking or !attacker_charge.is_charged():
			return
		
		RotationManager.rotate_towards_target(model, camera_focus, 0)
		attack()

func attack() -> void:
	attacker_charge.resource = 0
	
	attacking = true
	player_attacked.emit()
	
	await get_tree().physics_frame
	attack_hitbox.set_collider_state(true)
	attack_active_timer.start()
	await attack_active_timer.timeout
	attack_hitbox.set_collider_state(false)
	
	attacking = false
