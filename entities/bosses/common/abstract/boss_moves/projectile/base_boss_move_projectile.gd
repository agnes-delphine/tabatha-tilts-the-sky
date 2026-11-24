extends BaseBossMoveTargetPlayer
class_name BaseBossMoveProjectile

@onready var projectile_source: BossProjectileSourceComponent = %BossProjectileSourceComponent
@export var projectile_speed := 30.0
@export var projectile_type := DamageInstance.AvoidanceType.NONE
@export var random_projectile_type := RandomProjectileType.NONE

enum RandomProjectileType {
	NONE,
	TOGETHER,
	SEPARATE
}
func _get_random_projectile_type() -> DamageInstance.AvoidanceType:
	return DamageInstance.AvoidanceType.values().pick_random()
