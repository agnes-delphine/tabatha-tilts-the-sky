extends StateComponent
class_name PlayerStateComponent

enum PlayerState {
	IDLE,
	BUSY
}

func _ready() -> void:
	current_state = PlayerState.IDLE
