class_name MainScene
extends Node2D

@export var player_scene: PackedScene = preload("res://scenes/player_scene.tscn")
@export var enemy_basic: PackedScene = preload("res://scenes/enemy_basic.tscn")

@onready var Instantiater = get_tree().get_root().get_child(0).Instantiater
@onready var player: Player = Instantiater.make_instance("res://scenes/player_scene.tscn")

# Spawn
func spawn_enemy(enemy_scene: PackedScene, pos: Vector2) -> void:
	#var mob = enemy_scene.instantiate()
	var mob = Instantiater.make_instance("res://scenes/enemy_basic.tscn")
	mob.position = pos
	self.add_child(mob)
	#mob._player = player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#player = Instantiater.make_instance("res://scenes/player_scene.tscn")
	self.add_child(player)
	spawn_enemy(enemy_basic, Vector2(250, 250))
	spawn_enemy(enemy_basic, Vector2(1000, 1000))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
