class_name CardinalDirection

const DIAGONAL := 0.70710678

const DIRECTION_VECTORS := [
	Vector2(0, -1),
	Vector2(DIAGONAL, -DIAGONAL),
	Vector2(1, 0),
	Vector2(DIAGONAL, DIAGONAL),
	Vector2(0, 1),
	Vector2(-DIAGONAL, DIAGONAL),
	Vector2(-1, 0),
	Vector2(-DIAGONAL, -DIAGONAL),
]

const GRID_OFFSETS := {
	Enums.CardinalDirection.NORTH: Vector2i(0, -1),
	Enums.CardinalDirection.NORTH_EAST: Vector2i(1, -1),
	Enums.CardinalDirection.EAST: Vector2i(1, 0),
	Enums.CardinalDirection.SOUTH_EAST: Vector2i(1, 1),
	Enums.CardinalDirection.SOUTH: Vector2i(0, 1),
	Enums.CardinalDirection.SOUTH_WEST: Vector2i(-1, 1),
	Enums.CardinalDirection.WEST: Vector2i(-1, 0),
	Enums.CardinalDirection.NORTH_WEST: Vector2i(-1, -1),
}

const ROTATIONS := {
	Enums.CardinalDirection.NORTH: 0.0,
	Enums.CardinalDirection.NORTH_EAST: PI * 0.25,
	Enums.CardinalDirection.EAST: PI * 0.5,
	Enums.CardinalDirection.SOUTH_EAST: PI * 0.75,
	Enums.CardinalDirection.SOUTH: PI,
	Enums.CardinalDirection.SOUTH_WEST: PI * 1.25,
	Enums.CardinalDirection.WEST: PI * 1.5,
	Enums.CardinalDirection.NORTH_WEST: PI * 1.75,
}
