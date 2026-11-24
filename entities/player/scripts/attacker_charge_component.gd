extends ResourceComponent
class_name AttackerChargeComponent

@onready var attacker: AttackerComponent = %AttackerComponent
@onready var attacker_state: AttackerStateComponent = %AttackerStateComponent
@onready var charger_timer: Timer = %ChargerTimer
@onready var attack_charge_bar: AttackChargeBar = %AttackChargeBar

## How long between each charge tick.
@export var charge_interval := 0.5
## How much to increase the charge by each tick.
@export var increase_rate := 10.0

## How much the poise damage is multiplied by on a charged hit.
@export var poise_damage_multiplier := 4

var decaying := false

func _ready() -> void:
	charger_timer.start(charge_interval)
	resource_changed.connect(_on_resource_changed)

func _on_charger_timer_timeout() -> void:
	if attacker_state.is_state(attacker_state.AttackerState.READY):
		increase(increase_rate)

func _on_resource_changed(update: ResourceUpdate) -> void:
	## sfx
	#if update.current_value == update.max_value:
		#do_sfx()
	TweenManager.tween_bar(attack_charge_bar, update.current_value)

func is_power_attack() -> bool:
	return resource >= max_resource
