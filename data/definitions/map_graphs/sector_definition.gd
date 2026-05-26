class_name SectorDefinition
extends Resource

@export var id: StringName

# Each direction correspopnds to an approach lane
@export var lane: Enums.CardinalDirection
# Each map layer is a concentric circle
@export var layer: Enums.MapLayer

@export var section_ids: Array[StringName]
@export var waypoint_ids: Array[StringName]

@export var neighboring_sector_ids: Array[StringName]

@export var world_bounds: Rect2

@export var flags: PackedInt32Array
