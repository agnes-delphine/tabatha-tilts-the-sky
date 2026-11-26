extends Control
class_name DeathMenu

const MAIN_MENU = "res://ui/menus/main_menu/main_menu.tscn"

func _on_menu_button_pressed() -> void:
	LoadingManager.load_scene(MAIN_MENU)

func _on_quit_button_pressed() -> void:
	get_tree().quit()
