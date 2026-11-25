extends Area3D
class_name ParryHitbox

func set_collider_state(state: bool) -> void:
	set_deferred("monitorable", state)
	set_deferred("monitoring", state)
