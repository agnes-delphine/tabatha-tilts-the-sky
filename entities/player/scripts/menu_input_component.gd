extends Node
class_name MenuInputComponent

const PAUSE_MENU = preload("uid://b2gs46dyaoqj5")
var pause_menu : PauseMenu

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if not pause_menu:
			pause_menu = PAUSE_MENU.instantiate()
			get_tree().current_scene.add_child(pause_menu)
		
		pause_menu.toggle_pause()
