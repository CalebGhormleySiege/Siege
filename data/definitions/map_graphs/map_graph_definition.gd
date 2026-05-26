class_name MapGraphDefinition
extends Resource

# AssaultMapGraphDefinition Purpose:
# - Master topology
# - Graph connectivity
# - Authored geometry
# - Static traversal metadata

@export var waypoint_definitions: Array[WaypointDefinition]
@export var section_definitions: Array[SectionDefinition]
@export var sector_definitions: Array[SectorDefinition]

var waypoint_lookup: Dictionary
var section_lookup: Dictionary
var sector_lookup: Dictionary
