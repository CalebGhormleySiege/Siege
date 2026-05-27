# city_block_state.gd
class_name CityBlockState
extends RefCounted

var id: String = ""

var definition: CityBlockDefinition

# grid cell -> building_id
var occupied_cells := {}

# building_id -> occupied cells
var building_cells := {}

# building_id -> door cell
var building_origins := {}

func serialize() -> Dictionary:
	return {
		"id": id,
		"definition_id": definition.id if definition else "",
		"occupied_cells": occupied_cells,
		"building_cells": building_cells,
		"building_origins": building_origins
	}

func deserialize(data: Dictionary) -> void:
	id = data.get("id", "")
	# Note: definition must be loaded separately using definition_id
	occupied_cells = data.get("occupied_cells", {})
	building_cells = data.get("building_cells", {})
	building_origins = data.get("building_origins", {})
