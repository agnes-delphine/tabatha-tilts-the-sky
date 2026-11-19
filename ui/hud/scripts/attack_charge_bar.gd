extends ProgressBar
class_name AttackChargeBar

@export var offset := Vector2(-75, 30)

func _process(_delta: float) -> void:
	global_position = get_global_mouse_position() + offset
	
