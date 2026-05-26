# building_database.gd
#class_name BuildingDatabase
extends Node

static var _definitions := {}

static func initialize(
	database: BuildingDatabaseDefinition
):

	_definitions.clear()

	for building in database.buildings:

		if _definitions.has(building.id):

			push_error(
				"Duplicate building id: %s"
				% building.id
			)

			continue

		_definitions[building.id] = building

static func get_definition(
	id: String
) -> BuildingDefinition:

	if not _definitions.has(id):

		push_error(
			"Missing building definition: %s"
			% id
		)

		return null

	return _definitions[id]

static func validate_building(
	building: BuildingDefinition
):

	if building.id.is_empty():
		push_error("Building missing id")

	if building.shape == null:
		push_error(
			"%s missing shape"
			% building.id
		)

	if building.shape.cells.is_empty():
		push_error(
			"%s has no cells"
			% building.id
		)
