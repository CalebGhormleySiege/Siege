# building_adjacency_effect_definition.gd
class_name BuildingAdjacencyEffectDefinition
extends Resource

@export var target_building: BuildingDefinition

@export var effect_type: Enums.EffectType

# Per shared side
@export var value: float
