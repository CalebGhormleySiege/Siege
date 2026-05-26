class_name EnemyGraphTrackerState
extends RefCounted

var current_waypoint_id: StringName

var current_section_id: StringName
var current_sector_id: StringName

var current_lane: Enums.CardinalDirection
var current_layer: Enums.MapLayer

# Probably not using this
# 0.0 = start waypoint
# 1.0 = end waypoint
#var section_progress: float
