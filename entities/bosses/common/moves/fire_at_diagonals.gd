extends BaseBossMoveProjectile

func execute() -> void:
	var boss_pos := boss.global_position
	var diagonals: Array[Vector3] = [
		Vector3(-1, 0, -1).normalized(),
		Vector3(1, 0, -1).normalized(),
		Vector3(-1, 0, 1).normalized(),
		Vector3(1, 0, 1).normalized()
	]
	
	var offset = Vector3(0, 0, 0)
	
	for direction in diagonals:
		projectile_source.spawn_projectile(boss_pos, direction + offset, projectile_speed)
