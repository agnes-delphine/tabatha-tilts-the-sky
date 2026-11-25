extends Area3D
class_name Hurtbox

@export var healthComponent: HealthComponent
@export var invincibility_timer: Timer
@export var player_dodge: PlayerDodgeComponent
@onready var collider: CollisionShape3D = $CollisionShape3D

func set_collider_state(state: bool) -> void:
	collider.set_deferred("disabled", !state)

signal hurtbox_hit(hit_by: Hitbox)

var hitboxes_hit: Array[Hitbox] = []

func _on_area_entered(area: Area3D) -> void:
	if area is Hitbox:
		if is_instance_valid(player_dodge) and player_dodge.try_dodge(area):
			return ## dodge sfx?
		else:
			_try_damage(area)

func _on_area_exited(area: Area3D) -> void:
	if area is Hitbox:
		hitboxes_hit.erase(area)

func _try_damage(hitbox: Hitbox) -> void:
	if hitbox in hitboxes_hit:
		return

	if invincibility_timer.time_left > 0:
		return

	hitboxes_hit.append(hitbox)

	invincibility_timer.start()
	healthComponent.damage(hitbox.damage_instance)
	hurtbox_hit.emit(hitbox)
