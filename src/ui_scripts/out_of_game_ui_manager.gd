extends Control

@onready var Animation_Player = get_node("Animation Player")

var ui_scenes = {"settings": "res://scenes/ui_scenes/settings_menu.tscn", "main_menu" : "res://scenes/ui_scenes/main_menu.tscn", "pause_menu" : "res://scenes/ui_scenes/pause_menu.tscn"}
var current_scene = null
var last_scene = null

var scene_reference = null

func switch_scene(new_scene) ->void:
	if ui_scenes.has(new_scene):
		if scene_reference!=null:
			scene_reference.queue_free()
		var new_scene_node = get_tree().get_root().get_child(0).Instantiater.make_instance(ui_scenes[new_scene])
		add_child(new_scene_node)
		scene_reference = new_scene_node
		new_scene_node.toggle_interactive(true)
		last_scene = current_scene
		current_scene = new_scene

func toggle_interactive(yes_or_no) ->void:
	
	for child in get_children():
		if child.has_method("toggle_interactive"):
			child.toggle_interactive(yes_or_no)

func into_pause_transition() ->void:
	Animation_Player.play("Into_Pause")

func out_of_pause_transition() ->void:
	Animation_Player.play("Out_Of_Pause")

func get_last() ->String:
	return last_scene
