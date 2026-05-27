# fortress_state.gd
class_name FortressState
extends RefCounted

var id: String = ""

var tick: int = 0

var resource_state: ResourceState

var building_state_map := {}

# building_id -> BuildingState

var city_blocks: Array[CityBlockState]

var factions := {}

# faction_id -> FactionState

var simulation_random_seed: int = 0

func serialize() -> Dictionary:
	var building_data := {}
	for building_id in building_state_map:
		var building: BuildingState = building_state_map[building_id]
		building_data[building_id] = building.serialize()
	
	var city_block_data := []
	for city_block in city_blocks:
		city_block_data.append(city_block.serialize())
	
	var faction_data := {}
	for faction_id in factions:
		var faction = factions[faction_id]
		if faction.has_method("serialize"):
			faction_data[faction_id] = faction.serialize()
	
	return {
		"id": id,
		"tick": tick,
		"resource_state": resource_state.serialize() if resource_state else {},
		"building_state_map": building_data,
		"city_blocks": city_block_data,
		"factions": faction_data,
		"simulation_random_seed": simulation_random_seed
	}

func deserialize(data: Dictionary) -> void:
	id = data.get("id", "")
	tick = data.get("tick", 0)
	simulation_random_seed = data.get("simulation_random_seed", 0)
	
	# Deserialize resource state
	if resource_state == null:
		resource_state = ResourceState.new()
	var resource_data = data.get("resource_state", {})
	if resource_data:
		resource_state.deserialize(resource_data)
	
	# Deserialize building states
	building_state_map.clear()
	var building_data = data.get("building_state_map", {})
	for building_id in building_data:
		var building = BuildingState.new()
		building.deserialize(building_data[building_id])
		building_state_map[building_id] = building
	
	# Deserialize city blocks
	city_blocks.clear()
	var city_block_data = data.get("city_blocks", [])
	for cb_data in city_block_data:
		var city_block = CityBlockState.new()
		city_block.deserialize(cb_data)
		city_blocks.append(city_block)
	
	# Deserialize factions
	factions.clear()
	var faction_data = data.get("factions", {})
	for faction_id in faction_data:
		var faction = factions.get(faction_id)
		if faction and faction.has_method("deserialize"):
			faction.deserialize(faction_data[faction_id])
