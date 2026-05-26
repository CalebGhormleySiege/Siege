class_name BuildingShapeDefinition
extends Resource

@export var id: String

# Base orientation
# Local tile offsets relative to door tile.
# Door tile itself should ALWAYS be Vector2i.ZERO
@export var base_cells: Array[Vector2i]

@export var rotation_mode: Enums.RotationModeType = Enums.RotationModeType.FOUR_WAY

# Door direction in default rotation
@export var door_direction: Enums.RotationType

# Generated automatically
var rotations: Array[Array]
