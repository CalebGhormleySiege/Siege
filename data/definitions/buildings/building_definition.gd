# building_definition.gd
class_name BuildingDefinition
extends Resource

@export var id: String

@export var display_name: String
@export var job_name: String

@export var description: String

@export var shape: BuildingShapeDefinition

@export var max_health: float = 100.0

@export var max_workers: int = 0

@export var production_ticks: int = 0

@export var resource_inputs: Array[ResourceStackDefinition]
@export var resource_outputs: Array[ResourceStackDefinition]

@export var optional_inputs: Array[OptionalResourceDefinition]

@export var adjacency_effects: Array[BuildingAdjacencyEffectDefinition]

@export var inherent_effects: Array[BuildingInherentEffectDefinition]

@export var storage_definitions: Array[BuildingStorageDefinition]

# Housing or passive generation
@export var passive_resource_outputs: Array[ResourceStackDefinition]

@export var ideologies: Array[Enums.IdeologyType]

@export var requires_auxiliary_quarters: bool = false

@export var base_experience_decay_on_worker_change: float = 0.15
