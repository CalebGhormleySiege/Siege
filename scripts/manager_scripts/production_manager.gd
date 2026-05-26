# production_manager.gd
class_name ProductionManager
extends RefCounted

var fortress_state: FortressState

func process_tick():

	for building_id in fortress_state.building_state_map:

		var building: BuildingState = fortress_state.building_state_map[building_id]

		if not can_produce(building):
			continue

		building.production_progress += 1

		var ticks_required: int = get_adjusted_production_ticks(
			building
		)

		if building.production_progress >= ticks_required:

			complete_production(building)

			building.production_progress = 0

func get_adjusted_production_ticks(
	building: BuildingState
	) -> int:
		
	var base_ticks: int = max(
		1,
		building.definition.production_ticks
	)
	
	var efficiency := calculate_efficiency(
		building
	)
	
	# Prevent divide-by-zero
	efficiency = max(0.05, efficiency)
	
	var adjusted := int(
		ceil(base_ticks / efficiency)
	)
	
	# Always at least 1 tick
	return max(1, adjusted)

func can_produce(building: BuildingState) -> bool:

	if building.current_state != Enums.BuildingStateType.ACTIVE:
		return false

	if building.assigned_workers <= 0:
		return false

	for input in building.definition.resource_inputs:

		if not fortress_state.resource_state.has_resource(
			input.resource_type,
			input.quantity
		):
			return false

	return true

func complete_production(building: BuildingState):

	var efficiency := calculate_efficiency(building)

	for input in building.definition.resource_inputs:

		fortress_state.resource_state.remove_resource(
			input.resource_type,
			input.quantity
		)

	for output in building.definition.resource_outputs:

		var amount: int = floor(
			output.quantity * efficiency
		)

		fortress_state.resource_state.add_resource(
			output.resource_type,
			amount
		)

	building.add_experience(1.0)

func calculate_efficiency(
	building: BuildingState
) -> float:

	var labor: float = building.get_labor_efficiency()

	var experience: float = building.get_experience_efficiency()

	var damage: float = building.get_damage_efficiency()

	var adjacency: float = building.adjacency_modifiers.get(
		Enums.EffectType.EFFICIENCY,
		1.0
	)

	return (
		labor
		* experience
		* damage
		* adjacency
	)
