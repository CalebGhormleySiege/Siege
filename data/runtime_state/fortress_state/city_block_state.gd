# city_block_state.gd
class_name CityBlockState
extends RefCounted

var definition: CityBlockDefinition

# grid cell -> building_id
var occupied_cells := {}

# building_id -> occupied cells
var building_cells := {}

# building_id -> door cell
var building_origins := {}
