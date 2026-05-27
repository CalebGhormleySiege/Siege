class_name SectionState
extends RefCounted

var id: StringName = ""

var traversal_cost: float = 1.0

var obstruction_state: Enums.ObstructionState
var trench_state: Enums.TrenchState

var enemy_count: int = 0
var friendly_count: int = 0

var enemies: Array[int]

var cover_value: float = 0.0

var structural_integrity: float = 1.0

var is_traversable: bool = true

func serialize() -> Dictionary:
	return {
		"id": id,
		"traversal_cost": traversal_cost,
		"obstruction_state": obstruction_state,
		"trench_state": trench_state,
		"enemy_count": enemy_count,
		"friendly_count": friendly_count,
		"enemies": enemies,
		"cover_value": cover_value,
		"structural_integrity": structural_integrity,
		"is_traversable": is_traversable
	}

func deserialize(data: Dictionary) -> void:
	id = StringName(data.get("id", ""))
	traversal_cost = data.get("traversal_cost", 1.0)
	obstruction_state = data.get("obstruction_state", Enums.ObstructionState.NONE)
	trench_state = data.get("trench_state", Enums.TrenchState.NONE)
	enemy_count = data.get("enemy_count", 0)
	friendly_count = data.get("friendly_count", 0)
	enemies = data.get("enemies", [])
	cover_value = data.get("cover_value", 0.0)
	structural_integrity = data.get("structural_integrity", 1.0)
	is_traversable = data.get("is_traversable", true)
