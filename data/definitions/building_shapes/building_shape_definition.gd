class_name BuildingShapeDefinition
extends Resource

@export var id: String

# Base orientation
# Local tile offsets relative to door tile.
# Door tile itself should ALWAYS be Vector2i.ZERO
@export var base_cells: Array[Vector2i]

@export var rotation_mode: Enums.RotationMode = Enums.RotationMode.FOUR_WAY

@export var entrance_direction: Vector2i

# Generated automatically
var rotations: Array[Array]
