# resource_state.gd
class_name ResourceState
extends RefCounted

var id: String = ""

# ResourceType -> quantity
var quantities := {}

# ResourceType -> lifetime produced
var produced_totals := {}

# ResourceType -> lifetime consumed
var consumed_totals := {}

# ResourceType -> reserved quantity
var reserved_quantities := {}

func serialize() -> Dictionary:
	return {
		"id": id,
		"quantities": quantities,
		"produced_totals": produced_totals,
		"consumed_totals": consumed_totals,
		"reserved_quantities": reserved_quantities
	}

func deserialize(data: Dictionary) -> void:
	id = data.get("id", "")
	
	quantities = data.get("quantities", {})
	
	produced_totals = data.get(
		"produced_totals",
		{}
	)
	
	consumed_totals = data.get(
		"consumed_totals",
		{}
	)
	
	reserved_quantities = data.get(
		"reserved_quantities",
		{}
	)
