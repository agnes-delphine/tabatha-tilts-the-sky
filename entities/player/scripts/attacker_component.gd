extends Node
class_name AttackerComponent

@onready var camera_component: CameraComponent = %CameraComponent
@onready var camera_focus: Node3D = %CameraFocus

@onready var attack_hitbox: Hitbox = %AttackHitbox
@onready var attack_active_timer: Timer = %AttackActiveTimer

@onready var attacker_state: AttackerStateComponent = %AttackerStateComponent
@onready var attacker_charge: AttackerChargeComponent = %AttackerChargeComponent

signal player_attacked()

func _ready() -> void:
	attack_collider.disabled = true
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ready_blade"):
		attacker_state.set_state(attacker_state.AttackerState.READY)
		camera_component.set_look_at_target(camera_focus)
	elif event.is_action_released("ready_blade"):
		attacker_state.set_state(attacker_state.AttackerState.IDLE)
		camera_component.set_look_at_target(null)
		attack()

func attack() -> void:
	player_attacked.emit()
	reset_damage()
	attacker_charge.set_charge(0)
	
	if attacker_charge.is_power_attack():
		attack_hitbox.damage_instance.poise_damage *= attacker_charge.poise_damage_multiplier
	
	attack_hitbox.set_collider_state(false)
	attack_active_timer.start()
	await attack_active_timer.timeout
	attack_hitbox.set_collider_state(true)
	
	reset_damage()

func reset_damage() -> void:
	attack_hitbox.damage_instance.poise_damage = attack_hitbox.base_damage_instance.poise_damage
	attack_hitbox.damage_instance.health_damage = attack_hitbox.base_damage_instance.health_damage
	
