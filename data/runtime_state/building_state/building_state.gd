# building_state.gd
class_name BuildingState
extends RefCounted

var id: String = ""

var definition: BuildingDefinition

# Grid location of door/origin
var grid_position: Vector2i

var rotation: Enums.RotationType

var current_state: Enums.BuildingStateType = Enums.BuildingStateType.UNDER_CONSTRUCTION

# Health
var health: float

# Production
var production_progress: int = 0

# Experience
var experience: float = 0.0
var level: int = 1

# Labor
var assigned_workers: int = 0

# Faction assignment
var managing_faction_id: String = ""

# Runtime effect accumulation
var effect_accumulation := {}

# Storage runtime state
var storage := {}

# Cached adjacency bonuses
var adjacency_modifiers := {}

# Disabled manually?
var is_enabled: bool = true

func serialize() -> Dictionary:
	return {
		"id": id,
		"definition_id": definition.id,
		"position": grid_position,
		"rotation": rotation,
		"current_state": current_state,
		"health": health,
		"production_progress": production_progress,
		"experience": experience,
		"level": level,
		"assigned_workers": assigned_workers,
		"managing_faction_id": managing_faction_id,
		"effect_accumulation": effect_accumulation,
		"storage": storage,
		"adjacency_modifiers": adjacency_modifiers,
		"is_enabled": is_enabled
	}

func deserialize(data: Dictionary) -> void:
	id = data.get("id", "")
	# Note: definition must be loaded separately using definition_id
	grid_position = data.get("position", Vector2i.ZERO)
	rotation = data.get("rotation", Enums.RotationType.NORTH_EAST)
	current_state = data.get("current_state", Enums.BuildingStateType.UNDER_CONSTRUCTION)
	health = data.get("health", 0.0)
	production_progress = data.get("production_progress", 0)
	experience = data.get("experience", 0.0)
	level = data.get("level", 1)
	assigned_workers = data.get("assigned_workers", 0)
	managing_faction_id = data.get("managing_faction_id", "")
	effect_accumulation = data.get("effect_accumulation", {})
	storage = data.get("storage", {})
	adjacency_modifiers = data.get("adjacency_modifiers", {})
	is_enabled = data.get("is_enabled", true)
