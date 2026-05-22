extends Button

@export var soldier_scene: PackedScene  # Drag Soldier.tscn into this in the editor

func _ready():
	pressed.connect(_on_pressed)

func _on_pressed():
	if not soldier_scene:
		push_error("Soldier scene not assigned!")
		return

	var soldier = soldier_scene.instantiate()
	
	# Choose where to add the soldier
	get_tree().current_scene.add_child(soldier)  # Or another node like a 'World' node

	soldier.global_position = global_position + Vector2(0, -200)  # Example position

	GameManager.add_soldier(soldier)
