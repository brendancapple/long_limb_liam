extends Button


var can_be_interacted = true


func toggle_interactive(yes_or_no):
	#This shouldn't be relevant later
	if yes_or_no:
		mouse_filter=MouseFilter.MOUSE_FILTER_STOP
	else:
		mouse_filter=MouseFilter.MOUSE_FILTER_IGNORE
	can_be_interacted = yes_or_no
	

@export var what_method_does_this_button_do := ""
@export var args := []

func _on_pressed() -> void:
	
	if can_be_interacted and what_method_does_this_button_do!="":
		
		get_tree().get_root().get_child(0).generic_method_call(what_method_does_this_button_do, args)
			
