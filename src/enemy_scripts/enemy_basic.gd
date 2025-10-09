extends CharacterBody2D


@export var drag_acceleration = 5.0
@export var drag_friction = 0.5

var acceleration = Vector2(0,0)
var grabbed = false

func mouse_displacement() -> Vector2:
	var mouse = get_global_mouse_position() # get_viewport().get_mouse_position()
	return mouse - position
	
func apply_friction(a: Vector2, v: Vector2, coefficient: float, delta: float) -> Vector2:
	var output = v - (v * coefficient * delta)
	if output.dot(v) < 0:
		#print("->", v.dot(v))
		return Vector2(0,0)
	return output


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = Vector2(0,0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(grabbed)
	if grabbed:
		acceleration = drag_acceleration * (get_global_mouse_position() - global_position) * delta
		velocity += acceleration
	velocity = apply_friction(acceleration, velocity, drag_friction, delta)
	move_and_slide()
		


func _on_hitbox_area_entered(area: Area2D) -> void:
	print("Enemy Collided with: ", area.name)
	if area.name == "Grabbox":
		grabbed = true
	pass # Replace with function body.


func _on_hitbox_area_exited(area: Area2D) -> void:
	print("Enemy Disconnected with: ", area.name)
	if area.name == "Grabbox":
		grabbed = false
	pass # Replace with function body.
