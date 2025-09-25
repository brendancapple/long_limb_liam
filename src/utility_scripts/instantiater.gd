extends Node

var scenes_to_be_loaded = ["res://scenes/ui_scenes/pause_menu.tscn","res://scenes/ui_scenes/main_menu.tscn","res://scenes/enemy_basic.tscn", "res://scenes/main_scene.tscn"]

var loaded_scenes = []

#Preloads everything into memory at the start of runtime
func _ready() -> void:
	for scene_name in scenes_to_be_loaded:
		var loaded_scene = load(scene_name)
		loaded_scenes.append(loaded_scene)


#Input the file name for what you want to get back
func make_instance(Scene_to_be_instantiated) -> Node:
	var loaded_scene_index = scenes_to_be_loaded.find(Scene_to_be_instantiated)
	
	if loaded_scene_index == -1:
		return null
	
	var new_scene = loaded_scenes[loaded_scene_index].instantiate()
	return new_scene
