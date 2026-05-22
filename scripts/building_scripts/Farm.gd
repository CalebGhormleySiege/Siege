extends Building

class_name Farm

func _ready() -> void:
	super._ready()
	building_name = "Farm"
	production_type = "food"
	production_amount = 5
	production_interval = 5.0
