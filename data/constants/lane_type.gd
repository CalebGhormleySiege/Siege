# lane_type.gd
class_name LaneType



const ALL: Array[Enums.CardinalDirection] = [
	Enums.CardinalDirection.NORTH,
	Enums.CardinalDirection.NORTH_EAST,
	Enums.CardinalDirection.EAST,
	Enums.CardinalDirection.SOUTH_EAST,
	Enums.CardinalDirection.SOUTH,
	Enums.CardinalDirection.SOUTH_WEST,
	Enums.CardinalDirection.WEST,
	Enums.CardinalDirection.NORTH_WEST
]

const DISPLAY_NAMES := {
	Enums.CardinalDirection.NORTH: "North",
	Enums.CardinalDirection.NORTH_EAST: "NorthEast",
	Enums.CardinalDirection.EAST: "East",
	Enums.CardinalDirection.SOUTH_EAST: "SouthEast",
	Enums.CardinalDirection.SOUTH: "South",
	Enums.CardinalDirection.SOUTH_WEST: "SouthWest",
	Enums.CardinalDirection.WEST: "West",
	Enums.CardinalDirection.NORTH_WEST: "NorthWest"
}

const CLOCKWISE := {
	Enums.CardinalDirection.NORTH: Enums.CardinalDirection.NORTH_EAST,
	Enums.CardinalDirection.NORTH_EAST: Enums.CardinalDirection.EAST,
	Enums.CardinalDirection.EAST: Enums.CardinalDirection.SOUTH_EAST,
	Enums.CardinalDirection.SOUTH_EAST: Enums.CardinalDirection.SOUTH,
	Enums.CardinalDirection.SOUTH: Enums.CardinalDirection.SOUTH_WEST,
	Enums.CardinalDirection.SOUTH_WEST: Enums.CardinalDirection.WEST,
	Enums.CardinalDirection.WEST: Enums.CardinalDirection.NORTH_WEST,
	Enums.CardinalDirection.NORTH_WEST: Enums.CardinalDirection.NORTH
}

const COUNTER_CLOCKWISE := {
	Enums.CardinalDirection.NORTH: Enums.CardinalDirection.NORTH_WEST,
	Enums.CardinalDirection.NORTH_WEST: Enums.CardinalDirection.WEST,
	Enums.CardinalDirection.WEST: Enums.CardinalDirection.SOUTH_WEST,
	Enums.CardinalDirection.SOUTH_WEST: Enums.CardinalDirection.SOUTH,
	Enums.CardinalDirection.SOUTH: Enums.CardinalDirection.SOUTH_EAST,
	Enums.CardinalDirection.SOUTH_EAST: Enums.CardinalDirection.EAST,
	Enums.CardinalDirection.EAST: Enums.CardinalDirection.NORTH_EAST,
	Enums.CardinalDirection.NORTH_EAST: Enums.CardinalDirection.NORTH
}

const OPPOSITE := {
	Enums.CardinalDirection.NORTH: Enums.CardinalDirection.SOUTH,
	Enums.CardinalDirection.NORTH_EAST: Enums.CardinalDirection.SOUTH_WEST,
	Enums.CardinalDirection.EAST: Enums.CardinalDirection.WEST,
	Enums.CardinalDirection.SOUTH_EAST: Enums.CardinalDirection.NORTH_WEST,
	Enums.CardinalDirection.SOUTH: Enums.CardinalDirection.NORTH,
	Enums.CardinalDirection.SOUTH_WEST: Enums.CardinalDirection.NORTH_EAST,
	Enums.CardinalDirection.WEST: Enums.CardinalDirection.EAST,
	Enums.CardinalDirection.NORTH_WEST: Enums.CardinalDirection.SOUTH_EAST
}

static func get_display_name(lane: Enums.CardinalDirection) -> String:
	return DISPLAY_NAMES.get(lane, "Unknown")

static func get_clockwise(lane: Enums.CardinalDirection) -> Enums.CardinalDirection:
	return CLOCKWISE[lane]

static func get_counter_clockwise(lane: Enums.CardinalDirection) -> Enums.CardinalDirection:
	return COUNTER_CLOCKWISE[lane]

static func get_opposite(lane: Enums.CardinalDirection) -> Enums.CardinalDirection:
	return OPPOSITE[lane]

static func get_direction_vector(lane: Enums.CardinalDirection) -> Vector2:
	return CardinalDirection.DIRECTION_VECTORS[lane]
