extends Area3D
class_name ParryBox

@onready var projectile: BaseProjectile = $".."
@onready var hitbox: Hitbox = %Hitbox
@onready var model: CSGSphere3D = %CSGSphere3D

## The minimum charge required to parry this projectile.
@export_range(0.0, 100.0, 1.0) var minimum_charge_to_parry := 15.0

## The damage the projectile does if parried.
@export var damage_if_parried : DamageInstance

## Particles when parried
@export var particles : PackedScene

## What color is it when parried?
@export var parried_material : StandardMaterial3D

func _on_area_entered(area: Area3D) -> void:
	if area is not Hitbox:
		return
	
	area = area as Hitbox
	
	if not is_instance_valid(area.attacker):
		return
	
	if area.attacker.charge_at_release < minimum_charge_to_parry:
		return
		
	## reverse direction
	var new_direction = projectile.global_position.direction_to(BossManager.current_boss.global_position)
	projectile.direction = new_direction
	projectile.speed *= 2
	
	## sfx
	var fx : GPUParticles3D = particles.instantiate()
	projectile.add_child(fx)
	fx.global_position = projectile.global_position
	
	## trans
	model.material = parried_material
	
	## change owner to player
	hitbox.set_collision_layer_value(1, true)
	hitbox.set_collision_layer_value(3, false)
	
	hitbox.set_collision_mask_value(1, false)
	hitbox.set_collision_mask_value(3, true)
	
	hitbox.damage_instance = damage_if_parried
	
	queue_free()
	
