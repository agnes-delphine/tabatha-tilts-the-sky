extends BaseBossMove

func execute_move() -> void:
	var center_pos = ArenaManager.arena_center.global_position
	var target_pos := Vector3(
		center_pos.x,
		0.0,
		center_pos.z
	)
	
	if tween: 
		tween.kill()
	
	tween = create_tween()
	tween.tween_property(boss, "global_position", target_pos, 0.5)

func is_valid() -> bool:
	return boss.global_position.distance_to(ArenaManager.arena_center.global_position) >= 10.0
