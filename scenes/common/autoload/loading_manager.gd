extends Node

const LOADING_SCREEN = preload("uid://bj1a42embcbvg")
signal scene_loaded

func load_scene(scene: String, show_loading_bar := true) -> void:
	var loading : LoadingScreen = LOADING_SCREEN.instantiate()
	loading.next_scene_path = scene
	loading.show_loading_bar = show_loading_bar
	
	get_tree().root.add_child(loading)
	
	await loading.scene_loaded
	scene_loaded.emit()

func load_packed_scene(scene: PackedScene, show_loading_bar := true) -> void:
	load_scene(scene.resource_path, show_loading_bar)
