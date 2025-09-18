extends Control


func _ready() -> void:
	#Instantly pause the tree, do set up processes
	#get_tree().set_paused(true)
	pass


#Definitely not basically just a reimplimentation of call 
#For signalling up the tree, buttons will be defined to signal up to this, but will call different methods between them
func generic_method_call(which_method_to_call : String, parameter_array = null) -> void:
	if (parameter_array == null):
		call(which_method_to_call)
	else:
		callv(which_method_to_call, parameter_array)

#Methods to write later
func create_game():
	pass

func end_game():
	pass

func pause_game():
	pass

func unpause_game():
	pass
