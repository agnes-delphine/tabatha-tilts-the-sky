extends Node
class_name BossProjectileSourceComponent

@export var basic_projectile_scene: PackedScene
@export var dashable_projectile_scene: PackedScene
@export var slideable_projectile_scene: PackedScene
@export var parriable_projectile_scene: PackedScene

func spawn_projectile(
		pos: Vector3,
		direction: Vector3,
		speed: float,
		type: DamageInstance.AvoidanceType = DamageInstance.AvoidanceType.NONE
) -> BaseProjectile:
	return create_projectile(pos, direction, speed, _get_scene_for_type(type))

func _get_scene_for_type(type: DamageInstance.AvoidanceType) -> PackedScene:
	match type:
		DamageInstance.AvoidanceType.SLIDE:
			return slideable_projectile_scene
		DamageInstance.AvoidanceType.DASH:
			return dashable_projectile_scene
		DamageInstance.AvoidanceType.PARRY:
			return parriable_projectile_scene
		_:
			return basic_projectile_scene

func create_projectile(
		pos: Vector3,
		direction: Vector3,
		speed: float,
		projectile_scene: PackedScene
) -> BaseProjectile:
	var projectile := projectile_scene.instantiate() as BaseProjectile
	add_child(projectile)
	projectile.global_position = pos
	projectile.activate(direction, speed)
	return projectile
