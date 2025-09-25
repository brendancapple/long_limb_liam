extends Control

@onready var Animation_Player = get_node("Animation Player")

var is_paused = true


func start_pause():
	get_tree().set_pause(true)
	is_paused = true
	get_tree().get_root().get_child(0).UI_Manager.into_pause_transition()
	Animation_Player.play("Into_Pause")

func unpause_game():
	get_tree().get_root().get_child(0).UI_Manager.toggle_interactive(false)
	get_tree().get_root().get_child(0).UI_Manager.out_of_pause_transition()
	Animation_Player.play("Out_Of_Pause")

func finish_pause():
	get_tree().get_root().get_child(0).UI_Manager.toggle_interactive(true)

func finish_unpause():
	
	get_tree().set_pause(false)
	is_paused = false
