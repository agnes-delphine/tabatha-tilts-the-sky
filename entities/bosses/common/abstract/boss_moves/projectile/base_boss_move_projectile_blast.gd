extends BaseBossMoveProjectile
class_name BaseBossMoveProjectileBlast

@export var pellet_count: int = 5
@export var spread_degrees: float = 40.0
@export var jitter_degrees: float = 0.0

func execute() -> void:
	var player_pos := get_player_pos()
	var boss_pos := boss.global_position

	var to_player := player_pos - boss_pos
	to_player.y = 0.0
	var aim_direction := to_player.normalized()

	var spread := deg_to_rad(spread_degrees)

	for i in pellet_count:
		var t := 0.0 if pellet_count == 1 else float(i) / (pellet_count - 1) - 0.5

		var angle := t * spread + deg_to_rad(randf_range(-jitter_degrees, jitter_degrees))

		var direction := aim_direction.rotated(Vector3.UP, angle)
		projectile_source.spawn_projectile(boss_pos, direction, projectile_speed, projectile_type)
