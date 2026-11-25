extends Node
class_name BossProjectileSourceComponent

@onready var projectile_manager: BossProjectileManagerComponent = %BossProjectileManagerComponent

@export var basic_projectile_scene: PackedScene
@export var dashable_projectile_scene: PackedScene
@export var slideable_projectile_scene: PackedScene
@export var parriable_projectile_scene: PackedScene

@export var prewarm_count: int = 8
@export var max_pool_size: int = 64

var _pools: Dictionary = {}

func _ready() -> void:
	for scene in [
		basic_projectile_scene,
		dashable_projectile_scene,
		slideable_projectile_scene,
		parriable_projectile_scene,
	]:
		if scene != null:
			_prewarm(scene, prewarm_count)

func spawn_projectile(
		pos: Vector3,
		direction: Vector3,
		speed: float,
		type: DamageInstance.AvoidanceType = DamageInstance.AvoidanceType.NONE
) -> BaseProjectile:
	return create_projectile(pos, direction, speed, _get_scene_for_type(type))

func _get_scene_for_type(type: DamageInstance.AvoidanceType) -> PackedScene:
	match type:
		DamageInstance.AvoidanceType.SLIDE:
			return slideable_projectile_scene
		DamageInstance.AvoidanceType.DASH:
			return dashable_projectile_scene
		DamageInstance.AvoidanceType.PARRY:
			return parriable_projectile_scene
		_:
			return basic_projectile_scene

func create_projectile(
		pos: Vector3,
		direction: Vector3,
		speed: float,
		projectile_scene: PackedScene
) -> BaseProjectile:
	var projectile := _acquire(projectile_scene)
	projectile.global_position = pos
	projectile.activate(direction, speed)
	
	projectile_manager.active_projectiles.append(projectile)
	
	return projectile

# pooling
 
func _get_pool(scene: PackedScene) -> Array:
	if not _pools.has(scene):
		_pools[scene] = []
	return _pools[scene]
 
func _prewarm(scene: PackedScene, count: int) -> void:
	var pool := _get_pool(scene)
	for i in count:
		var projectile := _instantiate(scene)
		projectile.deactivate()
		pool.append(projectile)
 
func _instantiate(scene: PackedScene) -> BaseProjectile:
	var projectile := scene.instantiate() as BaseProjectile
	projectile.set_meta(&"pool_scene", scene)
	projectile.finished.connect(_release, CONNECT_REFERENCE_COUNTED)
	add_child(projectile)
	return projectile
 
func _acquire(scene: PackedScene) -> BaseProjectile:
	var pool := _get_pool(scene)
	while not pool.is_empty():
		var projectile := pool.pop_back() as BaseProjectile
		if is_instance_valid(projectile):
			return projectile
	return _instantiate(scene)
 
func _release(projectile: BaseProjectile) -> void:
	if not is_instance_valid(projectile):
		return
	var scene := projectile.get_meta(&"pool_scene", null) as PackedScene
	var pool := _get_pool(scene) if scene != null else []
	if scene == null or pool.size() >= max_pool_size:
		projectile.queue_free()
		return
	if projectile in pool:
		return
	projectile.deactivate()
	projectile_manager.active_projectiles.erase(projectile)
	pool.append(projectile)
