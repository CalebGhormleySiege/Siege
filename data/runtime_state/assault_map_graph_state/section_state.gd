class_name SectionState
extends RefCounted

var traversal_cost: float = 1.0

var obstruction_state: Enums.ObstructionState
var trench_state: Enums.TrenchState

var enemy_count: int = 0
var friendly_count: int = 0

var enemies: Array[int]

var cover_value: float = 0.0

var structural_integrity: float = 1.0

var is_traversable: bool = true
