# building_placement_result.gd
class_name BuildingPlacementResult
extends RefCounted

var success: bool = false
var failure_reason: String = ""
var occupied_cells: Array[Vector2i]
