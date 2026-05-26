# optional_resource_definition.gd
class_name OptionalResourceDefinition
extends Resource

@export var resource_type: Enums.ResourceType
@export var quantity: int

# Bonus if supplied
@export var efficiency_bonus: float = 0.0
@export var waste_reduction: float = 0.0
@export var injury_reduction: float = 0.0
