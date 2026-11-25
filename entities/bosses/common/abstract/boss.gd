extends Node3D
class_name Boss

@export var boss_id : StringName

@export var boss_health : BossHealthComponent
@export var boss_poise : BossPoiseComponent

@export var projectile_source : BossProjectileSourceComponent

func _ready() -> void:
	BossManager.register_boss(self)
