extends Area3D
class_name Hitbox

@onready var collider: CollisionShape3D = $CollisionShape3D

@export var base_damage_instance : DamageInstance
var damage_instance : DamageInstance

func set_collider_state(state: bool) -> void:
	collider.disabled = !state
	
func _ready() -> void:
	if not is_instance_valid(base_damage_instance):
		return
	
	damage_instance = DamageInstance.new(
		base_damage_instance.health_damage, 
		base_damage_instance.poise_damage,
		base_damage_instance.damage_type,
		base_damage_instance.avoidance_type)
