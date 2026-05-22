class_name BuildingDefinition
extends Resource

@export var id: String
@export var display_name: String
@export var build_costs: Dictionary[Enums.Resources, int]
@export var max_workers: int
@export var min_workers: int
@export var production_rates: Dictionary[Enums.Resources, int]
@export var hitpoints: int = 100
@export var shape: BuildingShapeDefinition
