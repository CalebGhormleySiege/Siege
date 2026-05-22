extends Node2D
class_name Building

@export var building_name: String = ""
@export var health: float = 100.0
@export var max_workers: int = 5
@export var wood_cost: int = 0
@export var stone_cost: int = 0

@export var production_type: String = ""
@export var production_amount: int = 0
@export var production_interval: float = 10.0

var workers: Array[Person] = []
var production_timer: float = 0.0

func _ready() -> void:
	add_to_group("buildings")
	production_timer = production_interval

func _process(delta: float) -> void:
	if production_type != "" and not workers.is_empty():
		production_timer -= delta
		if production_timer <= 0:
			produce()
			production_timer = production_interval

func produce() -> void:
	# Calculate total production based on number of workers
	var total_production: int = production_amount * workers.size()
	if total_production > 0:
		GameManager.add_resource(production_type, total_production)

func add_worker(person: Person) -> bool:
	if workers.size() < max_workers:
		workers.append(person)
		return true
	return false

func remove_worker(person: Person) -> void:
	workers.erase(person)
