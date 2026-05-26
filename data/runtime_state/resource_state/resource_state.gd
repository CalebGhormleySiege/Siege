# resource_state.gd
class_name ResourceState
extends RefCounted

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
		"quantities": quantities,
		"produced_totals": produced_totals,
		"consumed_totals": consumed_totals,
		"reserved_quantities": reserved_quantities
	}

func deserialize(data: Dictionary):
	
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
