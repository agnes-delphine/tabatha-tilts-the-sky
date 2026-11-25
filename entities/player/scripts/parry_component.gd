extends Node
class_name ParryComponent

@onready var parry_hitbox: ParryHitbox = %ParryHitbox
@onready var parry_active_timer: Timer = %ParryActiveTimer
@onready var parry_cooldown_timer: Timer = %ParryCooldownTimer
@onready var attacker_charge: AttackerChargeComponent = %AttackerChargeComponent

@export var parry_duration := 0.2
@export var parry_cooldown := 1.0

var can_parry := true

func _ready() -> void:
	parry_hitbox.set_collider_state(false)
	
	parry_active_timer.timeout.connect(_on_parry_active_timeout)
	parry_cooldown_timer.timeout.connect(_on_parry_cooldown_timeout)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("parry"):
		if !can_parry:
			return
		
		parry()

func parry() -> void:
	parry_active_timer.start(parry_duration)
	parry_hitbox.set_collider_state(true)
	can_parry = false

func _on_parry_active_timeout() -> void:
	parry_hitbox.set_collider_state(false)
	parry_cooldown_timer.start(parry_cooldown)

func _on_parry_cooldown_timeout() -> void:
	can_parry = true
