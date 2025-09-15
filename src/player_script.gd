extends Node2D

# Member Variables
@onready var _player = $Player
@onready var _player_sprite = $Player/PlayerSprite
@onready var _player_hitbox = $Player/PlayerHitbox
@onready var _hand = $Hand
@onready var _hand_sprite = $Hand/HandSprite
@onready var _hand_hitbox = $Hand/HandHitbox

@export var speed = 400
@export var friction = 2.0

@export var default_hand_distance = 10

var player_acceleration = Vector2(0.0, 0.0)

var hand_acceleration = Vector2(0.0, 0.0)
var hand_displacement = Vector2(0.0, 0.0)
var hand_state = 0 # 0: Idle  1: Extending  2: Latched  3: Pull  4: Push

# Movement Handling
func process_movement(delta: float) -> void:
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	
	player_acceleration = input_direction * speed
	player_acceleration -= _player.velocity * friction;
	_player.velocity += player_acceleration * delta
	
	if (input_direction == Vector2(0,0)):
		_player_sprite.play("idle")
	else:
		_player_sprite.play("walk")
		
# Hand Handling
func position_hand(aim: Vector2) -> void:
	aim = aim.normalized()
	print(aim)
	hand_displacement = _hand.position - _player.position
	print(hand_displacement)
	match hand_state:
		0: # IDLE
			print(_player_hitbox.shape.radius)
			_hand.position = _player.position + (_player_hitbox.shape.radius + default_hand_distance) * aim
		1: # EXTEND
			pass
		2: # LATCHED
			pass
		3: # PULL
			pass
		4: # PUSH
			pass
		_: # Default
			print("Error")
			pass
	print(_hand.position)
	print("-")

# Aim Handling
func process_aim() -> Vector2:
	var mouse = get_viewport().get_mouse_position()
	var aim = mouse - _player.position
	return aim

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position_hand(process_aim())
	process_movement(delta)
	_player.move_and_slide()
	
