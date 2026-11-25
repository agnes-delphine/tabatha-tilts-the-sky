extends Node
class_name BossProjectileManagerComponent

@onready var projectile_source: BossProjectileSourceComponent = %BossProjectileSourceComponent

var active_projectiles : Array[BaseProjectile]

func _physics_process(delta: float) -> void:
	for projectile in active_projectiles:
		if is_instance_valid(projectile):
			projectile.global_position += projectile.direction * projectile.speed * delta
