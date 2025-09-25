extends Control


func toggle_interactive(yes_or_no):
	
	for child in get_children():
		if child.has_method("toggle_interactive"):
			child.toggle_interactive(yes_or_no)
