extends BaseBossActionComponent
class_name BossActionProjectileBurstComponent

@onready var targets_player: BossActionTargetsPlayerComponent = $BossActionTargetsPlayerComponent
@onready var projectile: BossActionProjectileComponent = $BossActionProjectileComponent

## Self Explanatory
@export var pellet_count: int = 5
## Set Spread
@export var spread_degrees: float = 40.0
## Random Spread
@export var randomized_spread_degrees: float = 0.0

func execute() -> void:
	var player_pos := targets_player.get_player_pos()
	
	var boss := BossManager.current_boss
	var boss_pos := boss.global_position

	var to_player := player_pos - boss_pos
	to_player.y = 0.0
	var aim_direction := to_player.normalized()

	var spread := deg_to_rad(spread_degrees)

	if projectile.random_projectile_type == projectile.RandomProjectileType.TOGETHER:
		projectile.projectile_type = projectile._get_random_projectile_type()
	
	for i in pellet_count:
		var t := 0.0 if pellet_count == 1 else float(i) / (pellet_count - 1) - 0.5

		var angle := t * spread + deg_to_rad(randf_range(-randomized_spread_degrees, randomized_spread_degrees))

		var direction := aim_direction.rotated(Vector3.UP, angle)
		if projectile.random_projectile_type == projectile.RandomProjectileType.SEPARATE:
			projectile.projectile_source.spawn_projectile(boss_pos, direction, projectile.projectile_speed, projectile._get_random_projectile_type())
		else:
			projectile.projectile_source.spawn_projectile(boss_pos, direction, projectile.projectile_speed, projectile.projectile_type)
