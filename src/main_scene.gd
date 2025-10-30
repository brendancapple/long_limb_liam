class_name MainScene
extends Node2D

@export var player_scene: PackedScene = preload("res://scenes/player_scene.tscn")

@onready var Instantiater = get_tree().get_root().get_child(0).Instantiater
@onready var player: Player = Instantiater.make_instance("res://scenes/player_scene.tscn")
@onready var enemy_manager: Node = $EnemyManager

# Spawn
func random_spawn() -> void:
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#player = Instantiater.make_instance("res://scenes/player_scene.tscn")
	self.add_child(player)
	enemy_manager.player = player
	enemy_manager.start_timer()
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
