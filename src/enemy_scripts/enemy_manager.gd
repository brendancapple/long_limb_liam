extends Node

@onready var Instantiater = get_tree().get_root().get_child(0).Instantiater
@export var player: Player

@onready var enemies = $Enemies
@onready var spawn_path = $SpawnPath
@onready var spawn_timer = $SpawnTimer
@onready var spawn_location = $SpawnPath/SpawnLocation

func start_timer() -> void:
	spawn_timer.start()

func spawn_enemy(filename: String, pos: Vector2) -> void:
	#var mob = enemy_scene.instantiate()
	var mob = Instantiater.make_instance(filename)
	mob.player = player
	mob.position = pos
	self.enemies.add_child(mob)
	#mob._player = player

func _on_spawn_timer_timeout() -> void:
	spawn_location.progress_ratio = randf()
	
	var spawn_pos = Vector2(randf()-0.5, randf()-0.5).normalized() * 1400
	spawn_enemy("res://scenes/enemy_basic.tscn", spawn_pos)
