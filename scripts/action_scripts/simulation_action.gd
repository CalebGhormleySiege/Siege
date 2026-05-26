# simulation_action.gd
class_name SimulationAction
extends RefCounted

var tick: int
var player_id: int

func execute(simulation):
	pass

func serialize() -> Dictionary:
	return {}
