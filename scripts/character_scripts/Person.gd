extends CharacterBody2D
class_name Person

@export var move_speed: float = 100.0
@export var health: float = 100.0
@export var hunger: float = 0.0
@export var max_hunger: float = 100.0

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

var current_job: String = "unassigned"
var current_state: String = "idle"
var target_pos: Vector2 = Vector2.ZERO
var workplace: Node2D = null
var home: Node2D = null

func _ready() -> void:
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0

func _physics_process(_delta: float) -> void:
	if not navigation_agent or navigation_agent.is_navigation_finished():
		return

	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	velocity = global_position.direction_to(next_path_position) * move_speed
	move_and_slide()

func set_movement_target(movement_target: Vector2) -> void:
	navigation_agent.target_position = movement_target
