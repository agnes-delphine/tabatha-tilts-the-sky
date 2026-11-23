extends Resource
class_name DamageInstance

enum DamageType {
	PLAYER,
	ENEMY
}

enum AvoidanceType {
	NONE,
	SLIDE,
	DASH,
	PARRY
}

@export var health_damage : int
@export var poise_damage : int
@export var damage_type : DamageType = DamageType.ENEMY
@export var avoidance_type : AvoidanceType = AvoidanceType.NONE

func _init(
	init_health_damage: int = 1,
	init_poise_damage: int = 0,
	init_damage_type: DamageType = DamageType.ENEMY,
	init_avoidance_type: AvoidanceType = AvoidanceType.NONE
) -> void:
	health_damage = init_health_damage
	poise_damage = init_poise_damage
	damage_type = init_damage_type
	avoidance_type = init_avoidance_type
