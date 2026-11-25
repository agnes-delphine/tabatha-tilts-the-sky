extends BaseBossMove

@export var radius := 10.0

func execute_move() -> void:
	var angle := randf() * TAU
	var distance := sqrt(randf()) * radius
	var offset: Vector3 = Vector3(cos(angle), 0.0, sin(angle)) * distance
	var target_pos = boss.global_position + offset
	
	if tween: 
		tween.kill()
	
	tween = create_tween()
	tween.tween_property(boss, "global_position", target_pos, 0.5)

func is_valid() -> bool:
	return boss.global_position.distance_to(ArenaManager.arena_center.global_position) <= 50.0
