extends Node
class_name BossProjectileSourceComponent

@export var projectile_scene : PackedScene

func spawn_projectile(pos: Vector3, direction: Vector3, speed: float) -> Node:
	var projectile := projectile_scene.instantiate()
	add_child(projectile)
	projectile.global_position = pos
	if projectile.has_method("activate"):
		projectile.activate(direction, speed)
	return projectile
