# layer_type.gd
class_name LayerType

const ALL_INNER_TO_OUTER: Array[Enums.MapLayer] = [
	Enums.MapLayer.TOWN_SQUARE,
	Enums.MapLayer.INNER_FORTRESS,
	Enums.MapLayer.OUTER_FORTRESS,
	Enums.MapLayer.CURTAIN_WALL,
	Enums.MapLayer.GLACIS,
	Enums.MapLayer.THIRD_PARALLEL,
	Enums.MapLayer.NEAR_FIELD,
	Enums.MapLayer.SECOND_PARALLEL,
	Enums.MapLayer.MID_FIELD,
	Enums.MapLayer.FIRST_PARALLEL,
	Enums.MapLayer.FAR_FIELD,
	Enums.MapLayer.CIRCUMVALLATION,
	Enums.MapLayer.ENEMY_CAMP,
	Enums.MapLayer.CONTRAVALLATION
]

const DISPLAY_NAMES := {
	Enums.MapLayer.TOWN_SQUARE: "Town Square",
	Enums.MapLayer.INNER_FORTRESS: "Inner Fortress",
	Enums.MapLayer.OUTER_FORTRESS: "Outer Fortress",
	Enums.MapLayer.CURTAIN_WALL: "Curtain Wall",
	Enums.MapLayer.GLACIS: "Glacis",
	Enums.MapLayer.THIRD_PARALLEL: "Third Parallel",
	Enums.MapLayer.NEAR_FIELD: "Near Field",
	Enums.MapLayer.SECOND_PARALLEL: "Second Parallel",
	Enums.MapLayer.MID_FIELD: "Mid Field",
	Enums.MapLayer.FIRST_PARALLEL: "First Parallel",
	Enums.MapLayer.FAR_FIELD: "Far Field",
	Enums.MapLayer.CIRCUMVALLATION: "Circumvallation",
	Enums.MapLayer.ENEMY_CAMP: "Enemy Camp",
	Enums.MapLayer.CONTRAVALLATION: "Contravallation"
}

const DEPTH_INDEX := {
	Enums.MapLayer.TOWN_SQUARE: 0,
	Enums.MapLayer.INNER_FORTRESS: 1,
	Enums.MapLayer.OUTER_FORTRESS: 2,
	Enums.MapLayer.CURTAIN_WALL: 3,
	Enums.MapLayer.GLACIS: 4,
	Enums.MapLayer.THIRD_PARALLEL: 5,
	Enums.MapLayer.NEAR_FIELD: 6,
	Enums.MapLayer.SECOND_PARALLEL: 7,
	Enums.MapLayer.MID_FIELD: 8,
	Enums.MapLayer.FIRST_PARALLEL: 9,
	Enums.MapLayer.FAR_FIELD: 10,
	Enums.MapLayer.CIRCUMVALLATION: 11,
	Enums.MapLayer.ENEMY_CAMP: 12,
	Enums.MapLayer.CONTRAVALLATION: 13
}

const PARALLEL_LAYERS := {
	Enums.MapLayer.THIRD_PARALLEL: true,
	Enums.MapLayer.SECOND_PARALLEL: true,
	Enums.MapLayer.FIRST_PARALLEL: true,
	Enums.MapLayer.CIRCUMVALLATION: true,
	Enums.MapLayer.CONTRAVALLATION: true
}

const OPEN_FIELD_LAYERS := {
	Enums.MapLayer.GLACIS: true,
	Enums.MapLayer.NEAR_FIELD: true,
	Enums.MapLayer.MID_FIELD: true,
	Enums.MapLayer.FAR_FIELD: true
}

const FORTIFIED_LAYERS := {
	Enums.MapLayer.TOWN_SQUARE: true,
	Enums.MapLayer.INNER_FORTRESS: true,
	Enums.MapLayer.OUTER_FORTRESS: true,
	Enums.MapLayer.CURTAIN_WALL: true
}

static func get_display_name(layer: Enums.MapLayer) -> String:
	return DISPLAY_NAMES.get(layer, "Unknown")

static func get_depth_index(layer: Enums.MapLayer) -> int:
	return DEPTH_INDEX[layer]

static func is_parallel(layer: Enums.MapLayer) -> bool:
	return PARALLEL_LAYERS.has(layer)

static func is_open_field(layer: Enums.MapLayer) -> bool:
	return OPEN_FIELD_LAYERS.has(layer)

static func is_fortified(layer: Enums.MapLayer) -> bool:
	return FORTIFIED_LAYERS.has(layer)

static func get_inward_layer(layer: Enums.MapLayer) -> Variant:
	var index: int = DEPTH_INDEX[layer]

	if index <= 0:
		return null

	return ALL_INNER_TO_OUTER[index - 1]

static func get_outward_layer(layer: Enums.MapLayer) -> Variant:
	var index: int = DEPTH_INDEX[layer]

	if index >= ALL_INNER_TO_OUTER.size() - 1:
		return null

	return ALL_INNER_TO_OUTER[index + 1]
