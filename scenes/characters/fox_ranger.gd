extends CharacterBody2D

const speed: int = 200

@export var destination: Node2D
@onready var nav_agent = $NavigationAgent2D as NavigationAgent2D

func _physics_process(_delta: float) -> void:
	var direction = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = direction * speed
	move_and_slide()

func make_path() -> void:
	nav_agent.target_position = destination.global_position

func _on_timer_timeout() -> void:
	make_path()
