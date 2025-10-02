extends Node

@export var master_bus_value = 70
@export var sfx_bus_value = 70
@export var music_bus_value = 70

func _ready()->void:
	AudioServer.set_bus_volume_db(0, master_bus_value*0.6 -60 )
	AudioServer.set_bus_volume_db(1, sfx_bus_value*0.6 -60)
	AudioServer.set_bus_volume_db(2, music_bus_value*0.6 -60)

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
