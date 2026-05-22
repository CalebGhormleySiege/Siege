class_name BuildingState
extends RefCounted

var definition: BuildingDefinition

# Door/pivot position on world grid
var grid_position: Vector2i
	
# 0 = 0°
# 1 = 90°
# 2 = 180°
# 3 = 270°
var rotation: int = 0

var health: int

func _init(
	p_definition: BuildingDefinition,
	p_grid_position: Vector2i,
	p_rotation: int
):
	definition = p_definition
	grid_position = p_grid_position
	rotation = p_rotation
	health = definition.max_health
	
#func get_occupied_cells() -> Array[Vector2i]:
	#var results: Array[Vector2i] = []
#
	#var shape_cells := definition.shape.get_cells(rotation)
#
	#for local_cell in shape_cells:
		#results.append(grid_position + local_cell)
#
	#return results
