extends Control

@onready var actual_slider = get_node("Actual Slider")
@export var property_to_mirror : String 
var can_be_interacted = true
@export var what_method_does_this_slider_do := ""
@export var args := []

func _ready() -> void:
	if property_to_mirror != null:
		var grabbed_value = get_tree().get_root().get_child(0).Data_Manager.get(property_to_mirror)
		actual_slider.value = grabbed_value

func toggle_interactive(yes_or_no):
	#This shouldn't be relevant later
	if yes_or_no:
		actual_slider.mouse_filter=MouseFilter.MOUSE_FILTER_STOP
	else:
		actual_slider.mouse_filter=MouseFilter.MOUSE_FILTER_IGNORE
	can_be_interacted = yes_or_no


func _on_actual_slider_value_changed(value: float) -> void:
	if can_be_interacted and what_method_does_this_slider_do!="":
		var package_array = args.duplicate(true)
		package_array.append(value)
		get_tree().get_root().get_child(0).generic_method_call(what_method_does_this_slider_do, package_array)
			
