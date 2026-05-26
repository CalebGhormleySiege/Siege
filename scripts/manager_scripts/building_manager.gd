# building_manager.gd
class_name BuildingManager
extends RefCounted

var fortress_state: FortressState

var id_generator := BuildingIdGenerator.new()

func place_building(
	city_block_index: int,
	building_definition_id: String,
	origin: Vector2i,
	rotation: Enums.RotationType
) -> BuildingPlacementResult:

	var result := BuildingPlacementResult.new()

	var definition := BuildingDatabase.get_definition(
		building_definition_id
	)

	var city_block := fortress_state.city_blocks[city_block_index]

	var occupied_cells := get_rotated_cells(
		definition.shape,
		origin,
		rotation
	)

	for cell in occupied_cells:
		if city_block.occupied_cells.has(cell):
			result.failure_reason = "Cell occupied"
			return result

	var building := BuildingState.new()

	building.definition = definition
	building.grid_position = origin
	building.rotation = rotation
	building.health = definition.max_health

	var building_id := id_generator.generate()

	fortress_state.building_state_map[building_id] = building

	city_block.building_cells[building_id] = occupied_cells
	city_block.building_origins[building_id] = origin

	for cell in occupied_cells:
		city_block.occupied_cells[cell] = building_id

	result.success = true
	result.occupied_cells = occupied_cells

	return result

func get_rotated_cells(
	shape: BuildingShapeDefinition,
	origin: Vector2i,
	rotation: Enums.RotationType
) -> Array[Vector2i]:

	var results := []

	for cell in shape.cells:
		var rotated := rotate_cell(
			Vector2i(cell.x, cell.y),
			rotation
		)

		results.append(origin + rotated)

	return results

func rotate_cell(
	pos: Vector2i,
	rotation: Enums.RotationType
) -> Vector2i:

	match rotation:

		Enums.RotationType.NORTH_EAST:
			return pos

		Enums.RotationType.SOUTH_EAST:
			return Vector2i(-pos.y, pos.x)

		Enums.RotationType.SOUTH_WEST:
			return Vector2i(-pos.x, -pos.y)

		Enums.RotationType.NORTH_WEST:
			return Vector2i(pos.y, -pos.x)

	return pos	
