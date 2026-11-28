extends BaseBossActionComponent
class_name BossActionAOEDamageComponent

## The AOE damage instance being spawned for this move.
@export var aoe_entity : PackedScene
## The delay between the entity spawning, and it actually doing damage.
@export var delay := 1.0
## The duration for which the entity deals damage before disappearing.
@export var lifetime := 1.0
## The damage this AOE does.
@export var damage : DamageInstance

func get_aoe() -> BaseAOEDamageEntity:
	var aoe : BaseAOEDamageEntity = aoe_entity.instantiate()
	if !is_instance_valid(damage):
		damage = DamageInstance.new()
	
	aoe.delay = delay
	aoe.lifetime = lifetime
	aoe.damage = damage
	
	add_child(aoe)
	aoe.execute()
	return aoe
