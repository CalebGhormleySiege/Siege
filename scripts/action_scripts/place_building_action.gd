# place_building_action.gd
class_name PlaceBuildingAction
extends SimulationAction

var city_block_index: int

var building_definition_id: String

var grid_position: Vector2i

var rotation: Enums.RotationType

func execute(simulation):
	simulation.building_manager.place_building(
		city_block_index,
		building_definition_id,
		grid_position,
		rotation
	)
