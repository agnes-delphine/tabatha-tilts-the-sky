extends HealthComponent
class_name BossHealthComponent

@onready var boss_poise: BossPoiseComponent = %BossPoiseComponent
@onready var boss_death: BossDeathComponent = %BossDeathComponent

@export var slow_factor := 0.4
@export var slow_duration := 0.4

func damage(instance: DamageInstance) -> void:
	if boss_poise.has_resource_remaining() \
		and instance.damage_type == instance.DamageType.PLAYER:
		boss_poise.decrease(instance.poise_damage)
	else:
		super(instance)
		if not has_health_remaining():
			return
			
		boss_poise.resource = boss_poise.max_resource
		
		Engine.time_scale = slow_factor
		await get_tree().create_timer(slow_duration, true, false, true).timeout
		Engine.time_scale = 1.0
