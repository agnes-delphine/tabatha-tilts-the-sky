extends BaseBossMoveProjectile

func execute() -> void:
	var boss_pos := boss.global_position
	var cardinals: Array[Vector3] = [
		Vector3.FORWARD,
		Vector3.BACK,
		Vector3.LEFT,
		Vector3.RIGHT
	]
	
	for direction in cardinals:
		projectile_source.spawn_projectile(boss_pos, direction, projectile_speed)
