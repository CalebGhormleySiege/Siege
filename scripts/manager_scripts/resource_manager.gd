# resource_state.gd
class_name ResourceManager
extends RefCounted

var fortress_state: FortressState

func get_quantity(
	resource_type: Enums.ResourceType
) -> int:

	return fortress_state.resource_state.quantities.get(
		resource_type,
		0
	)
	
func get_available_quantity(
	resource_type: Enums.ResourceType
) -> int:

	var total: int = get_quantity(resource_type)

	var reserved: int = int(
		fortress_state.resource_state\
			.reserved_quantities.get(resource_type, 0)
	)

	return total - reserved

func add_resource(
	resource_type: Enums.ResourceType,
	amount: int
):

	if amount <= 0:
		return

	var current: int = get_quantity(resource_type)

	fortress_state.resource_state.quantities[
		resource_type
	] = current + amount

	var produced: int = int(
		fortress_state.resource_state\
			.produced_totals.get(resource_type, 0)
	)

	fortress_state.resource_state.produced_totals[
		resource_type
	] = produced + amount

func remove_resource(
	resource_type: Enums.ResourceType,
	amount: int
) -> bool:

	if amount <= 0:
		return true

	var available: int = get_available_quantity(
		resource_type
	)

	if available < amount:
		return false

	fortress_state.resource_state.quantities[
		resource_type
	] -= amount

	var consumed: int = int(
		fortress_state.resource_state\
			.consumed_totals.get(resource_type, 0)
	)


	fortress_state.resource_state.consumed_totals[
		resource_type
	] = consumed + amount

	return true

func has_resource(
	resource_type: Enums.ResourceType,
	amount: int
) -> bool:

	return get_available_quantity(
		resource_type
	) >= amount
