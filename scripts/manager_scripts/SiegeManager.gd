extends Node2D

class_name SiegeManager

@export var enemy_scene: PackedScene
@export var spawn_points: Array[Marker2D] = []
@export var spawn_interval: float = 15.0

var spawn_timer: float = 0.0

func _process(delta: float) -> void:
	spawn_timer -= delta
	if spawn_timer <= 0:
		_spawn_wave()
		_update_spawn_interval()

func _spawn_wave() -> void:
	var wave_size: int = 3 + (GameManager.current_act * 2)
	for i in range(wave_size):
		_spawn_enemy()

func _spawn_enemy() -> void:
	if not enemy_scene or spawn_points.is_empty(): return
	
	var spawn_point: Marker2D = spawn_points.pick_random()
	var enemy: Node2D = enemy_scene.instantiate()
	get_parent().add_child(enemy)
	enemy.global_position = spawn_point.global_position

func _update_spawn_interval() -> void:
	# Waves get more frequent as acts progress
	spawn_interval = max(5.0, 20.0 - (GameManager.current_act * 3))
	spawn_timer = spawn_interval
