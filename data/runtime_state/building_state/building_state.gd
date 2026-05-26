# building_state.gd
class_name BuildingState
extends RefCounted

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
		"definition_id": definition.id,
		"position": grid_position,
		"rotation": rotation,
		"health": health
	}
