extends Node
class_name PlayerDodgeComponent

@onready var player_state: PlayerStateComponent = %PlayerStateComponent
@onready var dash: DashComponent = %DashComponent
@onready var slide: SlideComponent = %SlideComponent
@onready var attacker_charge: AttackerChargeComponent = %AttackerChargeComponent

@export var charge_bonus_on_dodge := 15.0

func try_dodge(hitbox: Hitbox) -> bool:
	if hitbox.damage_instance.avoidance_type == DamageInstance.AvoidanceType.SLIDE \
		and slide.is_sliding:
			apply_dodge_bonus()
			return true
	if hitbox.damage_instance.avoidance_type == DamageInstance.AvoidanceType.DASH \
		and dash.is_dashing:
			apply_dodge_bonus()
			return true
	
	return false

func apply_dodge_bonus() -> void:
	## cooldown?
	attacker_charge.increase(charge_bonus_on_dodge)
	## sfx
