# fortress_simulation.gd
class_name FortressSimulation
extends RefCounted

var fortress_state := FortressState.new()

var action_queue := SimulationActionQueue.new()

var building_manager := BuildingManager.new()

var production_manager := ProductionManager.new()

var resource_manager := ResourceManager.new()

var adjacency_manager := BuildingAdjacencyManager.new()

var risk_manager := BuildingRiskManager.new()

func initialize():

	building_manager.fortress_state = fortress_state

	production_manager.fortress_state = fortress_state
	
	resource_manager.fortress_state = fortress_state

	adjacency_manager.fortress_state = fortress_state

	risk_manager.fortress_state = fortress_state

func tick():

	action_queue.process(self)

	production_manager.process_tick()

	risk_manager.process_tick()

	fortress_state.tick += 1
