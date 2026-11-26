extends Control

const OPTIONS_MENU = preload("uid://bgducnbjy2kcx")

func _on_start_pressed() -> void:
	LoadingManager.load_scene("res://scenes/main_scene.tscn")

func _on_options_pressed() -> void:
	var options = OPTIONS_MENU.instantiate()
	add_child(options)

func _on_quit_pressed() -> void:
	get_tree().quit()
