extends Node



func _process(_delta: float) -> void:
	if Input.is_action_just_released("Pause") and get_tree().paused == false :
		get_tree().get_root().get_child(0).pause_game()
	elif  Input.is_action_just_released("Pause"):
		get_tree().get_root().get_child(0).unpause_game()
