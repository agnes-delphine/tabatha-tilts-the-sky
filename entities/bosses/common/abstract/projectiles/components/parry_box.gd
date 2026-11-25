extends Area3D
class_name ParryBox

@onready var projectile: BaseProjectile = $".."
@onready var hitbox: Hitbox = %Hitbox
@onready var model: CSGBox3D = %CSGBox3D

## The damage the projectile does if parried.
@export var damage_if_parried : DamageInstance

## Particles when parried
@export var particles : PackedScene

## What color is it when parried?
@export var parried_material : StandardMaterial3D
var default_material : StandardMaterial3D

## How much charge do you get for parrying this projectile?
@export var charge_on_parried := 15.0

func _ready() -> void:
	default_material = model.material
	projectile.activated.connect(_on_projectile_activated)

func _on_projectile_activated() -> void:
	model.material = default_material
	
	## change owner back to enemy
	hitbox.set_collision_layer_value(1, false)
	hitbox.set_collision_layer_value(3, true)
	hitbox.set_collision_mask_value(1, true)
	hitbox.set_collision_mask_value(3, false)
	
	## reset damage
	hitbox.damage_instance = hitbox.base_damage_instance
	
	## enable collision of parry box
	set_deferred("monitoring", true)
	set_deferred("monitorable", true)

func _on_area_entered(area: Area3D) -> void:
	if area is not ParryHitbox:
		return
	
	area = area as ParryHitbox
	
	var attacker_charge : AttackerChargeComponent = PlayerManager.player.get_node_or_null("%AttackerChargeComponent")
	if is_instance_valid(attacker_charge):
		attacker_charge.increase(charge_on_parried)
	
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
	projectile._face_direction()
	
	## change owner of hitbox to player
	hitbox.set_collision_layer_value(1, true)
	hitbox.set_collision_layer_value(3, false)
	
	hitbox.set_collision_mask_value(1, false)
	hitbox.set_collision_mask_value(3, true)
	
	hitbox.damage_instance = damage_if_parried.duplicate()
	
	## disable collision of parry box
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)
