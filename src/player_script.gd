extends Node2D

# Member Variables
@onready var _player = $Player
@onready var _player_sprite = $Player/PlayerSprite
# @onready var _player_hitbox = $Player/Collider
@onready var _hand = $Hand
@onready var _hand_sprite = $Hand/HandSprite
# @onready var _hand_hitbox = $Hand/Grabbox

@export var max_health = 10
var health = max_health

@export var speed = 400
@export var friction = 2.0
@export var knockback = 500

@export var pull_acceleration = 10.0
@export var push_acceleration = 10.0
@export var aim_acceleration = 20.0
@export var pull_burst = 1000
@export var push_burst = 1000

@export var hand_static_friction = 2.0
@export var hand_sliding_friction = 1.0
@export var default_hand_distance = 100

var player_acceleration = Vector2(0.0, 0.0)

var hand_acceleration = Vector2(0.0, 0.0)
var hand_displacement = Vector2(0.0, 0.0)
var hand_target = Vector2(0.0, 0.0)

enum {IDLE, EXTEND, LATCHED, PULL, PUSH}
var hand_state = IDLE
var hand_latchnode: Area2D = null

var mouse: Vector2 = Vector2(0,0)

## Physics
func apply_friction(a: Vector2, v: Vector2, coefficient: float, delta: float) -> Vector2:
	var output = v - (v * coefficient * delta)
	if output.dot(v) < 0:
		#print("->", v.dot(v))
		return Vector2(0,0)
	return output
	
func apply_acceleration(a: Vector2, v: Vector2, delta: float):
	var output = v + a * delta
	if output.dot(v) < 0:
		#print("-->", output.dot(v))
		return Vector2(0, 0)
	return output
	
func apply_knockback(area: Area2D):
	_player.velocity -= (area.global_position - _player.global_position).normalized() * knockback


## Health Handling



##  Movement Handling
func process_movement(delta: float) -> void:
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	
	player_acceleration = input_direction * speed
	player_acceleration -= _player.velocity * friction;
	_player.velocity += player_acceleration * delta
	
	if (input_direction == Vector2(0,0)):
		_player_sprite.play("idle")
	else:
		_player_sprite.play("walk")
	
	_player_sprite.set_flip_h(_player.velocity.x<=0)
		
## Hand Handling
func position_hand(delta: float, mouse: Vector2, burst: bool) -> void:
	var aim = mouse - _player.position
	aim = aim.normalized()
	
	#print(aim)
	hand_displacement = _hand.position - _player.position
	#print(hand_displacement)
	#print(hand_state)
	
	match hand_state:
		IDLE:
			hand_target = _player.position + default_hand_distance  * aim
			hand_acceleration = (hand_target - _hand.position) * aim_acceleration
			_hand.velocity = apply_friction(hand_acceleration, _hand.velocity, hand_static_friction, delta)
		EXTEND:
			hand_target = _player.position + default_hand_distance  * aim
			hand_acceleration = (hand_target - _hand.position) * aim_acceleration
			_hand.velocity = apply_friction(hand_acceleration, _hand.velocity, hand_static_friction, delta)
		LATCHED:
			hand_acceleration = Vector2(0,0)
			_hand.velocity = Vector2(0,0)
			_hand.global_position = hand_latchnode.global_position
		PULL: 
			hand_target = _player.position + default_hand_distance  * aim
			hand_acceleration = (hand_target - _hand.position) * aim_acceleration
			_hand.velocity = apply_friction(hand_acceleration, _hand.velocity, hand_sliding_friction, delta)
			if burst:
				_hand.velocity -= aim * pull_burst
		PUSH:
			hand_acceleration = (mouse - _hand.position) * push_acceleration
			_hand.velocity = apply_friction(hand_acceleration, _hand.velocity, hand_sliding_friction, delta)
			if burst:
				_hand.velocity += aim * push_burst
		_:
			print("Error")
			pass
			
	_hand.velocity += hand_acceleration * delta
	#print("-")
	
func set_hand_state() -> bool:
	var prev = hand_state
	if prev == LATCHED:
		if Input.is_action_just_pressed("Pull"):
			hand_state = PULL
			return true
		if Input.is_action_just_pressed("Push"):
			hand_state = PUSH
			return true
		return false
	
	if Input.is_action_pressed("Pull"):
		hand_state = PULL
		return prev == IDLE
	if Input.is_action_pressed("Push"):
		hand_state = PUSH
		return prev == IDLE
		
	if hand_state == LATCHED:
		return false
	
	hand_state = IDLE
	return false

## Aim Handling
func process_mouse() -> Vector2:
	var mouse = get_global_mouse_position() # get_viewport().get_mouse_position()
	return mouse


## Godot

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position_hand(delta, process_mouse(), set_hand_state())
	process_movement(delta)
	_hand.move_and_slide()
	_player.move_and_slide()
	

## Collision Handling
func _on_grabbox_area_entered(area: Area2D) -> void:
	print("Player Collided with: ", area.name)
	if hand_state != IDLE && area.name == "Hitbox":
		hand_state = LATCHED
		hand_latchnode = area


func _on_hitbox_area_entered(area: Area2D) -> void:
	print(area.get_groups())
	if area.is_in_group("Enemy"):
		apply_knockback(area)
		health -= 1
		print(health)
	pass # Replace with function body.
