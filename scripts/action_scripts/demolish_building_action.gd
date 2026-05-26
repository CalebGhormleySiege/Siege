# demolish_building_action.gd
class_name DemolishBuildingAction
extends SimulationAction

var building_id: int

func execute(simulation):
	simulation.building_manager.demolish_building(building_id)
