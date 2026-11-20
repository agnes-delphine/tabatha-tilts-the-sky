extends BaseBossMoveTargetPlayer

@onready var projectile_source: BossProjectileSourceComponent = %BossProjectileSourceComponent

func execute() -> void:
	var player_pos := get_player_pos()
	var boss_pos := boss.global_position
	
	var direction = boss_pos.direction_to(player_pos)
	projectile_source.spawn_projectile(boss_pos, direction, 30)
