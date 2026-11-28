extends BaseBossActionComponent
class_name BossActionProjectileRadialComponent

@onready var projectile: BossActionProjectileComponent = $BossActionProjectileComponent

@export var projectile_count: int = 4
@export var start_angle_degrees: float = 0.0
@export var fire_delay := 0.0
@export var spawn_distance := 0.0
@export var inverse := false

func execute() -> void:
	var boss := BossManager.current_boss
	var boss_pos := boss.global_position
	var angle_step := TAU / projectile_count
	var start_angle := deg_to_rad(start_angle_degrees)

	if projectile.random_projectile_type == projectile.RandomProjectileType.TOGETHER:
		projectile.projectile_type = projectile._get_random_projectile_type()
		
	for i in projectile_count:
		var direction := Vector3.FORWARD.rotated(Vector3.UP, start_angle + angle_step * i)
		var spawn_pos = boss_pos
		if spawn_distance != 0.0:
			spawn_pos = boss_pos + (Vector3(spawn_distance, 0.0, spawn_distance) * direction)
		
		if inverse:
			direction = -direction
		
		if projectile.random_projectile_type == projectile.RandomProjectileType.SEPARATE:
			projectile.projectile_source.spawn_projectile(spawn_pos, direction, projectile.projectile_speed, projectile._get_random_projectile_type())
		else:
			projectile.projectile_source.spawn_projectile(spawn_pos, direction, projectile.projectile_speed, projectile.projectile_type)
		await get_tree().create_timer(fire_delay).timeout
