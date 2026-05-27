class_name SectorState
extends RefCounted

var id: StringName = ""

var pressure_value: float = 0.0

var friendly_strength: float = 0.0
var enemy_strength: float = 0.0

var active_obstructions: int = 0

var trench_progress: float = 0.0

var contested: bool = false

func serialize() -> Dictionary:
	return {
		"id": id,
		"pressure_value": pressure_value,
		"friendly_strength": friendly_strength,
		"enemy_strength": enemy_strength,
		"active_obstructions": active_obstructions,
		"trench_progress": trench_progress,
		"contested": contested
	}

func deserialize(data: Dictionary) -> void:
	id = StringName(data.get("id", ""))
	pressure_value = data.get("pressure_value", 0.0)
	friendly_strength = data.get("friendly_strength", 0.0)
	enemy_strength = data.get("enemy_strength", 0.0)
	active_obstructions = data.get("active_obstructions", 0)
	trench_progress = data.get("trench_progress", 0.0)
	contested = data.get("contested", false)
