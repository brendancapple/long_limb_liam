extends Control

@onready var actual_button = get_node("Actual Check Button")
@export var property_to_mirror : String 
var can_be_interacted = true
@export var what_method_does_this_button_do := ""
@export var args := []

func _ready() -> void:
	if property_to_mirror != null:
		var grabbed_value = get_tree().get_root().get_child(0).Data_Manager.get(property_to_mirror)
		actual_button.set_pressed(grabbed_value)

func toggle_interactive(yes_or_no):
	#This shouldn't be relevant later
	if yes_or_no:
		actual_button.mouse_filter=MouseFilter.MOUSE_FILTER_STOP
	else:
		actual_button.mouse_filter=MouseFilter.MOUSE_FILTER_IGNORE
	can_be_interacted = yes_or_no


func _on_actual_check_button_toggled(toggled_on: bool) -> void:
	if can_be_interacted and what_method_does_this_button_do!="":
		var package_array = args.duplicate(true)
		package_array.append(toggled_on)
		get_tree().get_root().get_child(0).generic_method_call(what_method_does_this_button_do, package_array)
			
