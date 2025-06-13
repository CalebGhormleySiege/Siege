extends TileMapLayer

var astar_grid = AStarGrid2D.new()
# Need to setup these values
const main_layer = 0
const main_source = 2
const path_taken_atlas_coords = Vector2i(2, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup_grid()
	show_path()
	
func  setup_grid():
	astar_grid.cell_shape = AStarGrid2D.CELL_SHAPE_ISOMETRIC_DOWN
	astar_grid.region = Rect2i(0,0,32,32)
	astar_grid.cell_size = Vector2i(144,72)
	astar_grid.update()
	print(astar_grid.get_id_path(Vector2i(0, 0), Vector2i(3, 4))) # Prints [(0, 0), (1, 1), (2, 2), (3, 3), (3, 4)]
	print(astar_grid.get_point_path(Vector2i(0, 0), Vector2i(3, 4))) # Prints [(0, 0), (16, 16), (32, 32), (48, 48), (48, 64)]

func show_path():
	var path_taken = astar_grid.get_id_path(Vector2i(0, 0), Vector2i(3, 4))
	for cell in path_taken:
		set_cell(cell, main_source, path_taken_atlas_coords)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
