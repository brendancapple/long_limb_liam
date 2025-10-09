extends CharacterBody2D

@export var max_health = 2
var health = max_health

@export var speed = 200
@export var knockback = 500

@export var drag_acceleration = 5.0
@export var drag_friction = 0.5

var facing = Vector2(0,-1)
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

func apply_knockback(area: Area2D):
	velocity -= (area.global_position - global_position).normalized() * knockback
	
func process_damage(area):
	health -= 1
	print("Enemy: " + str(health))

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
	else:
		velocity += ((speed * facing) - velocity) * delta
	velocity = apply_friction(acceleration, velocity, drag_friction, delta)
	move_and_slide()
		


func _on_hitbox_area_entered(area: Area2D) -> void:
	print("Enemy Collided with: ", area.name)
	if area.name == "Grabbox":
		grabbed = true
	if area.name == "Hitbox":
		apply_knockback(area)
		process_damage(area)


func _on_hitbox_area_exited(area: Area2D) -> void:
	print("Enemy Disconnected with: ", area.name)
	if area.name == "Grabbox":
		grabbed = false
	pass # Replace with function body.
