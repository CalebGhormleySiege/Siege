# building_inherent_effect_definition.gd
class_name BuildingInherentEffectDefinition
extends Resource

@export var effect_type: Enums.EffectType

# Base accumulation per tick
@export var base_value: float

# Threshold before event
@export var trigger_threshold: float = 100.0
