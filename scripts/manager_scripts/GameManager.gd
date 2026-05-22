extends Node2D

class_name GameManagerClass

# Resources
var wood: int = 100
var stone: int = 50
var food: int = 200
var iron: int = 0
var days_until_relief: int = 10
var current_act: int = 1

# Populations
var soldiers: Array[Node2D] = []
var commanders: Array[Node2D] = []
var citizens: Array[Node2D] = []
var engineers: Array[Node2D] = []

# Signals
signal resources_changed
signal resource_changed(type: String, amount: int)
signal population_changed

func _ready() -> void:
	add_to_group("game_manager")

func add_resource(type: String, amount: int) -> void:
	match type.to_lower():
		"wood": wood += amount
		"stone": stone += amount
		"food": food += amount
		"iron": iron += amount
		"days_until_relief": days_until_relief += amount
	resources_changed.emit()
	resource_changed.emit(type.to_lower(), get_resource(type.to_lower()))

func get_resource(type: String) -> int:
	match type.to_lower():
		"wood": return wood
		"stone": return stone
		"food": return food
		"iron": return iron
		"days_until_relief": return days_until_relief
	return 0

func has_resources(requirements: Dictionary) -> bool:
	return (wood >= requirements.get("wood", 0) and 
			stone >= requirements.get("stone", 0) and 
			food >= requirements.get("food", 0) and
			iron >= requirements.get("iron", 0))

func spend_resources(requirements: Dictionary) -> void:
	wood -= requirements.get("wood", 0)
	stone -= requirements.get("stone", 0)
	food -= requirements.get("food", 0)
	iron -= requirements.get("iron", 0)
	resources_changed.emit()
	resource_changed.emit("wood", wood)
	resource_changed.emit("stone", stone)
	resource_changed.emit("food", food)
	resource_changed.emit("iron", iron)

func add_citizen(unit: Node2D) -> void:
	if not citizens.has(unit):
		citizens.append(unit)
		population_changed.emit()

func remove_citizen(unit: Node2D) -> void:
	if citizens.has(unit):
		citizens.erase(unit)
		population_changed.emit()

func get_unassigned_citizens() -> Array[Node2D]:
	return citizens.filter(func(c): return c.current_job == "unassigned")

func assign_job(job_type: String) -> bool:
	var unassigned = get_unassigned_citizens()
	if unassigned.is_empty():
		return false
	
	var person = unassigned[0]
	# Logic to find a building of job_type and assign person to it
	var buildings = get_tree().get_nodes_in_group("buildings")
	for b in buildings:
		if b is Building and b.production_type == job_type:
			if b.add_worker(person):
				person.workplace = b
				person.current_job = job_type
				person.set_movement_target(b.global_position)
				return true
	return false
