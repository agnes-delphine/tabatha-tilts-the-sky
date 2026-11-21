extends BaseBossMoveProjectile

func execute() -> void:
	var player_pos := get_player_pos()
	var boss_pos := boss.global_position
	
	var direction = boss_pos.direction_to(player_pos)
	projectile_source.spawn_projectile(boss_pos, direction, projectile_speed)
