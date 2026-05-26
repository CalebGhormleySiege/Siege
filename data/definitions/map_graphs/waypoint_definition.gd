class_name WaypointDefinition
extends Resource

# WaypointDefinition Represents:
# - Crossroads
# - Breach entrances
# - Parallel traversal nodes
# - Obstruction interaction nodes
# - Spawnpoints

@export var id: StringName

# Each direction correspopnds to an approach lane
@export var lane: Enums.CardinalDirection
# Each map layer is a concentric circle
@export var layer: Enums.MapLayer

@export var world_position: Vector2

@export var waypoint_type: Enums.WaypointType

@export var inward_waypoints: Array[StringName]
@export var sideways_waypoints: Array[StringName]
@export var outward_waypoints: Array[StringName]

@export var connected_sections: Array[StringName]

@export var flags: PackedInt32Array
