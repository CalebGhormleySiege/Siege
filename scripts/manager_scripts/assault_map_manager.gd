# assault_map_manager.gd
class_name AssaultMapManager
extends Node

signal section_state_changed(section_id: StringName)
signal waypoint_state_changed(waypoint_id: StringName)
signal sector_state_changed(sector_id: StringName)

@export var graph_definition: MapGraphDefinition

var graph_state: MapGraphState

var waypoint_definitions: Dictionary = {}
var section_definitions: Dictionary = {}
var sector_definitions: Dictionary = {}

var waypoint_states: Dictionary = {}
var section_states: Dictionary = {}
var sector_states: Dictionary = {}

# Fast lookup:
# enemy_id -> EnemyGraphTracker
var enemy_trackers: Dictionary = {}

# Fast lookup:
# section_id -> PackedInt64Array(enemy ids)
var section_enemy_lookup: Dictionary = {}

func _ready() -> void:
	_initialize_graph()

# -------------------------------------------------------------------
# Initialization
# -------------------------------------------------------------------

func _initialize_graph() -> void:
	if graph_definition == null:
		push_error("AssaultMapManager requires graph_definition")
		return

	graph_state = MapGraphState.new()

	_register_definitions()
	_create_runtime_state()
	_initialize_section_enemy_lookup()

func _register_definitions() -> void:
	for waypoint in graph_definition.waypoint_definitions:
		waypoint_definitions[waypoint.id] = waypoint

	for section in graph_definition.section_definitions:
		section_definitions[section.id] = section

	for sector in graph_definition.sector_definitions:
		sector_definitions[sector.id] = sector

func _create_runtime_state() -> void:
	for waypoint_id in waypoint_definitions:
		var state := WaypointState.new()

		waypoint_states[waypoint_id] = state
		graph_state.waypoint_states[waypoint_id] = state

	for section_id in section_definitions:
		var state := SectionState.new()

		section_states[section_id] = state
		graph_state.section_states[section_id] = state

	for sector_id in sector_definitions:
		var state := SectorState.new()

		sector_states[sector_id] = state
		graph_state.sector_states[sector_id] = state

func _initialize_section_enemy_lookup() -> void:
	for section_id in section_definitions:
		section_enemy_lookup[section_id] = PackedInt64Array()

# -------------------------------------------------------------------
# Enemy Registration
# -------------------------------------------------------------------

func register_enemy(
	enemy_id: int,
	initial_section_id: StringName,
	initial_waypoint_id: StringName
) -> void:
	var tracker := EnemyGraphTrackerState.new()

	var section_definition: SectionDefinition = section_definitions[initial_section_id]
	var sector_definition: SectorDefinition = sector_definitions[section_definition.sector_id]

	tracker.current_section_id = initial_section_id
	tracker.current_waypoint_id = initial_waypoint_id
	tracker.current_sector_id = section_definition.sector_id

	tracker.current_lane = sector_definition.lane
	tracker.current_layer = sector_definition.layer

	enemy_trackers[enemy_id] = tracker

	_add_enemy_to_section(enemy_id, initial_section_id)

func unregister_enemy(enemy_id: int) -> void:
	if not enemy_trackers.has(enemy_id):
		return

	var tracker: EnemyGraphTrackerState = enemy_trackers[enemy_id]

	_remove_enemy_from_section(enemy_id, tracker.current_section_id)

	enemy_trackers.erase(enemy_id)

# -------------------------------------------------------------------
# Enemy Movement
# -------------------------------------------------------------------

func move_enemy_to_section(
	enemy_id: int,
	new_section_id: StringName,
	new_waypoint_id: StringName
) -> void:
	if not enemy_trackers.has(enemy_id):
		return

	var tracker: EnemyGraphTrackerState = enemy_trackers[enemy_id]

	if tracker.current_section_id == new_section_id:
		tracker.current_waypoint_id = new_waypoint_id
		return

	_remove_enemy_from_section(enemy_id, tracker.current_section_id)
	_add_enemy_to_section(enemy_id, new_section_id)

	var section_definition: SectionDefinition = section_definitions[new_section_id]
	var sector_definition: SectorDefinition = sector_definitions[section_definition.sector_id]

	tracker.current_section_id = new_section_id
	tracker.current_waypoint_id = new_waypoint_id
	tracker.current_sector_id = section_definition.sector_id

	tracker.current_lane = sector_definition.lane
	tracker.current_layer = sector_definition.layer

# -------------------------------------------------------------------
# Section Enemy Tracking
# -------------------------------------------------------------------

func _add_enemy_to_section(enemy_id: int, section_id: StringName) -> void:
	var enemies: PackedInt64Array = section_enemy_lookup[section_id]

	var array := Array(enemies)
	array.append(enemy_id)

	section_enemy_lookup[section_id] = PackedInt64Array(array)

	var state: SectionState = section_states[section_id]

	state.enemy_count += 1

func _remove_enemy_from_section(enemy_id: int, section_id: StringName) -> void:
	var enemies: PackedInt64Array = section_enemy_lookup[section_id]

	var array := Array(enemies)
	array.erase(enemy_id)

	section_enemy_lookup[section_id] = PackedInt64Array(array)

	var state: SectionState = section_states[section_id]

	state.enemy_count = max(0, state.enemy_count - 1)

# -------------------------------------------------------------------
# Section Queries
# -------------------------------------------------------------------

func get_section_definition(section_id: StringName) -> SectionDefinition:
	return section_definitions.get(section_id)

func get_section_state(section_id: StringName) -> SectionState:
	return section_states.get(section_id)

func get_sector_definition(sector_id: StringName) -> SectorDefinition:
	return sector_definitions.get(sector_id)

func get_sector_state(sector_id: StringName) -> SectorState:
	return sector_states.get(sector_id)

func get_waypoint_definition(waypoint_id: StringName) -> WaypointDefinition:
	return waypoint_definitions.get(waypoint_id)

func get_waypoint_state(waypoint_id: StringName) -> WaypointState:
	return waypoint_states.get(waypoint_id)

func get_enemies_in_section(section_id: StringName) -> PackedInt64Array:
	return section_enemy_lookup.get(section_id, PackedInt64Array())

# -------------------------------------------------------------------
# Traversal
# -------------------------------------------------------------------

func is_section_traversable(section_id: StringName) -> bool:
	var state: SectionState = section_states[section_id]

	return state.is_traversable

func get_section_traversal_cost(section_id: StringName) -> float:
	var state: SectionState = section_states[section_id]

	var cost := state.traversal_cost

	match state.obstruction_state:
		Enums.ObstructionState.ACTIVE:
			cost += 1000.0

		Enums.ObstructionState.DAMAGED:
			cost += 5.0

	match state.trench_state:
		Enums.TrenchState.SHALLOW:
			cost *= 0.9

		Enums.TrenchState.COMPLETE:
			cost *= 0.75

	return cost

# -------------------------------------------------------------------
# Obstruction Control
# -------------------------------------------------------------------

func set_section_obstruction_state(
	section_id: StringName,
	obstruction_state: Enums.ObstructionState
) -> void:
	var state: SectionState = section_states[section_id]

	state.obstruction_state = obstruction_state

	match obstruction_state:
		Enums.ObstructionState.ACTIVE:
			state.is_traversable = false

		Enums.ObstructionState.DESTROYED:
			state.is_traversable = true

	section_state_changed.emit(section_id)

# -------------------------------------------------------------------
# Trench Progression
# -------------------------------------------------------------------

func set_section_trench_state(
	section_id: StringName,
	trench_state: Enums.TrenchState
) -> void:
	var state: SectionState = section_states[section_id]

	state.trench_state = trench_state

	match trench_state:
		Enums.TrenchState.NONE:
			state.cover_value = 0.0

		Enums.TrenchState.SHALLOW:
			state.cover_value = 0.35

		Enums.TrenchState.COMPLETE:
			state.cover_value = 0.7

		Enums.TrenchState.COLLAPSED:
			state.cover_value = 0.1

	section_state_changed.emit(section_id)
