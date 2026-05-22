extends Person

class_name Citizen

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	GameManager.add_citizen(self)

func _exit_tree() -> void:
	GameManager.remove_citizen(self)

## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
