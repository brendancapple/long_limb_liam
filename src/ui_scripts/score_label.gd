extends Label

@onready var top_level_node = get_tree().get_root().get_child(0)

func toggle_interactive(yes_or_no):
	self.text = str(top_level_node.last_score)
