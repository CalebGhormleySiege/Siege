# fortress_state.gd
class_name FortressState
extends RefCounted

var tick: int = 0

var resource_state: ResourceState

var building_state_map := {}

# building_id -> BuildingState

var city_blocks: Array[CityBlockState]

var factions := {}

# faction_id -> FactionState

var simulation_random_seed: int = 0
