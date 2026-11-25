extends BaseBossMove

@onready var targets_player: BossActionTargetsPlayerComponent = $BossActionTargetsPlayerComponent

func execute_move() -> void:
	
	var boss_pos := boss.global_position
	var player_pos := targets_player.get_player_pos()

	var target_pos := Vector3(
		lerp(boss_pos.x, player_pos.x, 0.5),
		boss_pos.y,
		lerp(boss_pos.z, player_pos.z, 0.5)
	)

	if tween:
		tween.kill()

	tween = create_tween()
	tween.tween_property(boss, "global_position", target_pos, 0.5)

	RotationManager.rotate_towards_target(boss, targets_player.player, 0.1)

func is_valid() -> bool:
	return targets_player.get_player_pos().distance_to(boss.global_position) >= 10.0
