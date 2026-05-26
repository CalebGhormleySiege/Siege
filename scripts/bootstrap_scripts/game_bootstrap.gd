# game_bootstrap.gd

func _ready():

	var database := preload(
		"res://data/databases/buildings/building_database.tres"
	)

	BuildingDatabase.initialize(database)
