extends Node

@export var master_bus_value = 70
@export var sfx_bus_value = 70
@export var music_bus_value = 70
@export var full_screen = false



func _ready()->void:
	AudioServer.set_bus_volume_db(0, master_bus_value*0.6 -60 )
	AudioServer.set_bus_volume_db(1, sfx_bus_value*0.6 -60)
	AudioServer.set_bus_volume_db(2, music_bus_value*0.6 -60)
	match full_screen:
		true:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		false:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func update_bus(which_bus, new_value)->void:
	match which_bus:
		0:
			master_bus_value = new_value
			AudioServer.set_bus_volume_db(0, master_bus_value*0.6 -60 )
		1:
			sfx_bus_value = new_value
			AudioServer.set_bus_volume_db(1, sfx_bus_value*0.6 -60)
		2:
			music_bus_value = new_value
			AudioServer.set_bus_volume_db(2, music_bus_value*0.6 -60)

func toggle_full_screen(new_value) ->void:
	if full_screen!=new_value:
		full_screen = new_value
		match new_value:
			true:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			false:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
