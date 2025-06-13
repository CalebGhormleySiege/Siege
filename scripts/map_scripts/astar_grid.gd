extends AnimatedSprite2D

var astar_grid = AStarGrid2D.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	astar_grid.cell_shape = AStarGrid2D.CELL_SHAPE_ISOMETRIC_DOWN
	astar_grid.region = Rect2i(-32,-32,32,32)
	astar_grid.cell_size = Vector2i(144,72)
	astar_grid.update()
	print(astar_grid.get_id_path(Vector2i(0, 0), Vector2i(3, 4))) # Prints [(0, 0), (1, 1), (2, 2), (3, 3), (3, 4)]
	print(astar_grid.get_point_path(Vector2i(0, 0), Vector2i(3, 4))) # Prints [(0, 0), (16, 16), (32, 32), (48, 48), (48, 64)]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
