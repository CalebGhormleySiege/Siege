extends Building
class_name Woodcutter

func _ready() -> void:
	super._ready()
	building_name = "Woodcutter's Hut"
	production_type = "wood"
	production_amount = 5
	max_workers = 3
	wood_cost = 20
