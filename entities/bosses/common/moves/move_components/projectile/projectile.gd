extends BaseBossActionComponent
class_name BossActionProjectileComponent

## The speed of the projectiles.
@export var projectile_speed := 15.0
## The type of projectile this attack spawns. Will be overridden by randomized projectiles.
@export var projectile_type := DamageInstance.AvoidanceType.NONE
## Should the projectile type be randomized, and if so, how?
@export var random_projectile_type := RandomProjectileType.NONE

var projectile_source: BossProjectileSourceComponent

enum RandomProjectileType {
	## No random projectiles, uses projectile type set.
	NONE,
	## Randomized projectiles, all of same type.
	TOGETHER,
	## Randomized projectiles, all of different types.
	SEPARATE
}

func _ready() -> void:
	BossManager.boss_registered.connect(_on_boss_registered)

func _on_boss_registered(boss: Boss) -> void:
	projectile_source = boss.projectile_source
	
func _get_random_projectile_type() -> DamageInstance.AvoidanceType:
	return DamageInstance.AvoidanceType.values().pick_random()
