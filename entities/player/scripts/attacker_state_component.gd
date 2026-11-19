extends StateComponent
class_name AttackerStateComponent

enum AttackerState {
	IDLE,
	READY,
	ATTACKING,
}

func _ready() -> void:
	current_state = AttackerState.IDLE
