class_name SectionDefinition
extends Resource

# SectionDefinition represents the traversable space between two waypoints

@export var id: StringName

@export var sector_id: StringName

@export var start_waypoint_id: StringName
@export var end_waypoint_id: StringName

@export var traversal_direction: Enums.CardinalDirection

@export var local_bounds: Rect2

@export var world_curve: PackedVector2Array

@export var section_type: Enums.SectionType

@export var flags: PackedInt32Array
