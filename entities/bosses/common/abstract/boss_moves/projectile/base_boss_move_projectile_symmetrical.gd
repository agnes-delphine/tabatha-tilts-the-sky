extends BaseBossMoveProjectile
class_name BaseBossMoveProjectileSymmetrical

@export var projectile_count: int = 4
@export var start_angle_degrees: float = 0.0
@export var fire_delay := 0.0

func execute() -> void:
	var boss_pos := boss.global_position
	var angle_step := TAU / projectile_count
	var start_angle := deg_to_rad(start_angle_degrees)

	for i in projectile_count:
		var direction := Vector3.FORWARD.rotated(Vector3.UP, start_angle + angle_step * i)
		projectile_source.spawn_projectile(boss_pos, direction, projectile_speed, projectile_type)
		await get_tree().create_timer(fire_delay).timeout
