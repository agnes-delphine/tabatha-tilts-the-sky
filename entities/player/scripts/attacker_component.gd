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
	if event.is_action_pressed("ready_blade"):
		attacker_state.set_state(attacker_state.AttackerState.READY)
		
	elif event.is_action_released("ready_blade"):
		if attacking:
			return
		
		attacker_state.set_state(attacker_state.AttackerState.IDLE)
		RotationManager.rotate_towards_target(model, camera_focus, 0)
		await attack()

func attack() -> void:
	attacking = true
	player_attacked.emit()
	reset_damage()
	
	charge_at_release = attacker_charge.resource
	
	if attacker_charge.is_power_attack():
		attack_hitbox.damage_instance.poise_damage *= attacker_charge.poise_damage_multiplier
	attacker_charge.resource = 0
	
	await get_tree().physics_frame
	attack_hitbox.set_collider_state(true)
	attack_active_timer.start()
	await attack_active_timer.timeout
	attack_hitbox.set_collider_state(false)
	
	attacking = false
	reset_damage()

func reset_damage() -> void:
	attack_hitbox.damage_instance.poise_damage = attack_hitbox.base_damage_instance.poise_damage
	attack_hitbox.damage_instance.health_damage = attack_hitbox.base_damage_instance.health_damage
