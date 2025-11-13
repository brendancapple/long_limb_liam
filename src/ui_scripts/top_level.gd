extends Control

#Reference List
@onready var Instantiater = get_node("Instantiater")
@onready var Game_Holder = get_node("Game Viewport Holder/Viewport Control/Viewport")
@onready var Pause_Manager = get_node("Pause Manager")
@onready var UI_Manager = get_node("Out of Game UI Manager")
@onready var Data_Manager = get_node("Data Storage Manager")

var game_reference = null

func _ready() -> void:
	UI_Manager.switch_scene("main_menu")
	Pause_Manager.start_pause()

#Definitely not basically just a reimplimentation of call 
#For signalling up the tree, buttons will be defined to signal up to this, but will call different methods between them
func generic_method_call(which_method_to_call : String, parameter_array = null) -> void:
	if (parameter_array == null):
		call(which_method_to_call)
	else:
		callv(which_method_to_call, parameter_array)

#Methods to write later
func create_game()-> void:
	
	var new_game = Instantiater.make_instance("res://scenes/main_scene.tscn")
	Game_Holder.add_child(new_game)
	game_reference = new_game
	unpause_game()

func end_game()-> void:
	if !Pause_Manager.is_paused:
		Pause_Manager.start_pause()
	if game_reference != null:
		game_reference.queue_free()
		UI_Manager.switch_scene("end_scene")


func pause_game()-> void:
	Pause_Manager.start_pause()
	if game_reference!= null:
		UI_Manager.switch_scene("pause_menu")

func unpause_game()-> void:
	Pause_Manager.unpause_game()

func end_runtime()->void:
	get_tree().quit(0)

func back()->void:
	if (UI_Manager.get_last()!=null):
		UI_Manager.switch_scene(UI_Manager.get_last())

func switch_to(scene_to_switch_to) ->void:
	UI_Manager.switch_scene(scene_to_switch_to)

func update_bus(which_bus, new_value)->void:
	Data_Manager.update_bus(which_bus, new_value)

func toggle_full_screen(new_value)->void:
	Data_Manager.toggle_full_screen(new_value)

func change_screen_value(new_value)->void:
	Data_Manager.change_screen_value(new_value)
