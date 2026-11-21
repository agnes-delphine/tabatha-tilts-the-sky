extends BaseBossMoveTargetPlayer

func execute() -> void:
	var boss_pos := boss.global_position
	var player_pos := get_player_pos()

	var target_pos := Vector3(
		player_pos.x,
		boss_pos.y,
		player_pos.z
	)

	if tween:
		tween.kill()
	
	boss.hide()
	
	tween = create_tween()
	tween.tween_property(boss, "global_position", target_pos, 0.5)
	RotationManager.rotate_towards_target(boss, player, 0.1)
	
	await tween.finished
	
	boss.show()

func is_valid() -> bool:
	return get_player_pos().distance_to(boss.global_position) >= 10.0
