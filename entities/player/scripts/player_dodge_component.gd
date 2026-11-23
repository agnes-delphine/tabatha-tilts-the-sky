extends Node
class_name PlayerDodgeComponent

@onready var player_state: PlayerStateComponent = %PlayerStateComponent
@onready var dash: DashComponent = %DashComponent
@onready var slide: SlideComponent = %SlideComponent

func try_dodge(hitbox: Hitbox) -> bool:
	if hitbox.damage_instance.avoidance_type == DamageInstance.AvoidanceType.SLIDE \
		and slide.is_sliding:
			return true
	if hitbox.damage_instance.avoidance_type == DamageInstance.AvoidanceType.DASH \
		and dash.is_dashing:
			return true
	#if hitbox.damage_instance.avoidance_type == DamageInstance.AvoidanceType.PARRY \
	#	and parry.is_parrying:
	#		return true
	
	return false
