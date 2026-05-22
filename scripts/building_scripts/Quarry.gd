extends Building
class_name Quarry

func _ready() -> void:
	super._ready()
	building_name = "Quarry"
	production_type = "stone"
	production_amount = 3
	max_workers = 4
	wood_cost = 50
