extends CharacterBody2D

# Member Variables
@onready var _animated_sprite = $PlayerSprite

@export var speed = 400
@export var friction = 2.0
var acceleration = Vector2(0.0, 0.0)

# Movement Handling
func process_movement(delta: float):
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	
	acceleration = input_direction * speed
	acceleration -= velocity * friction;
	velocity += acceleration * delta
	
	if (input_direction == Vector2(0,0)):
		_animated_sprite.play("idle")
	else:
		_animated_sprite.play("walk")

# Aim Handling
func process_aim() -> Vector2:
	var mouse = get_viewport().get_mouse_position()
	var aim = position - mouse
	return aim

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	process_aim()
	process_movement(delta)
	move_and_slide()
	
