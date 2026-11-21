extends BaseBossMoveProjectile

func execute() -> void:
	var boss_pos := boss.global_position
	var directions: Array[Vector3] = [
		Vector3.FORWARD,
		Vector3.BACK,
		Vector3.LEFT,
		Vector3.RIGHT,
		Vector3(-1, 0, -1).normalized(),
		Vector3(1, 0, -1).normalized(),
		Vector3(-1, 0, 1).normalized(),
		Vector3(1, 0, 1).normalized()
	]
	
	for direction in directions:
		projectile_source.spawn_projectile(boss_pos, direction, projectile_speed)
