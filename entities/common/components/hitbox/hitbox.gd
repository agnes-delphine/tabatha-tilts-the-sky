extends Area3D
class_name Hitbox

@export var base_damage_instance : DamageInstance
var damage_instance : DamageInstance

func _ready() -> void:
	if not is_instance_valid(base_damage_instance):
		return
	
	damage_instance = DamageInstance.new(
		base_damage_instance.health_damage, 
		base_damage_instance.poise_damage,
		base_damage_instance.damage_type)
