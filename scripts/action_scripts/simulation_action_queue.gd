# simulation_action_queue.gd
class_name SimulationActionQueue
extends RefCounted

var queued_actions: Array[SimulationAction]

func enqueue(action: SimulationAction):
	queued_actions.append(action)

func process(simulation):
	queued_actions.sort_custom(
		func(a, b): return a.tick < b.tick
	)

	for action in queued_actions:
		action.execute(simulation)

	queued_actions.clear()
