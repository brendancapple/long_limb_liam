extends Node2D

@export var player_scene: PackedScene = preload("res://scenes/player_scene.tscn")
@export var enemy_basic: PackedScene = preload("res://scenes/enemy_basic.tscn")

# Spawn
func spawn_enemy(enemy_scene: PackedScene, pos: Vector2) -> void:
	var mob = enemy_scene.instantiate()
	mob.position = pos
	self.add_child(mob)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.add_child(player_scene.instantiate())
	spawn_enemy(enemy_basic, Vector2(250, 250))
	spawn_enemy(enemy_basic, Vector2(1000, 1000))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
