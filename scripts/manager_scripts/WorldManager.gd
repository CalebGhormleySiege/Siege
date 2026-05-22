extends Node2D

@onready var cam: Camera2D = $Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	InputManager.set_camera_reference(cam)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
