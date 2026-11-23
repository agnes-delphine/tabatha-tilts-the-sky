extends Node
class_name AttackerChargeComponent

@onready var attacker: AttackerComponent = %AttackerComponent
@onready var attacker_state: AttackerStateComponent = %AttackerStateComponent
@onready var charger_timer: Timer = %ChargerTimer

@export var max_charge := 100.0
@export var charge_interval := 0.5
@export var increase_rate := 10.0
@export var decay_rate := 5.0

@export var poise_damage_multiplier := 4

var charge := 0.0

## play sound effect and particles when fully charged, and particles while
## charging
func _ready() -> void:
	charger_timer.start(charge_interval)

func _on_charger_timer_timeout() -> void:
	if attacker_state.is_state(attacker_state.AttackerState.READY):
		set_charge(charge + increase_rate)
	elif attacker_state.is_state(attacker_state.AttackerState.IDLE):
		set_charge(charge - decay_rate)

func set_charge(new_charge) -> void:
	charge = clampf(new_charge, 0, max_charge)

func is_power_attack() -> bool:
	return charge >= max_charge
