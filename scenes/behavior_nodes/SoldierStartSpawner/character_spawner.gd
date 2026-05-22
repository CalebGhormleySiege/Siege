@tool
extends Node2D

@export var grid_size: Vector2 = Vector2(64, 32)

@export var soldier_scene: PackedScene
@export var soldier_count: int = 1
#@export var spawn_spacing: Vector2 = Vector2(16, 8)  # Optional offset to avoid stacking

func _ready():
	var soldiers_parent = get_tree().current_scene.get_node("People/Soldiers")
	
	for i in range(soldier_count):
		var soldier = soldier_scene.instantiate()
		soldiers_parent.add_child(soldier)
		soldier.setup(self.z_index, global_position)
		GameManager.add_soldier(soldier)

func _process(_delta):
	if Engine.is_editor_hint():
		position.x = round(position.x / grid_size.x) * grid_size.x
		position.y = round(position.y / grid_size.y) * grid_size.y
