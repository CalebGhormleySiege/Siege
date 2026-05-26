# assault_path_manager.gd
class_name AssaultPathManager
extends Node

@export var assault_map_manager: AssaultMapManager

# Cache:
# start_waypoint:end_waypoint -> path
var cached_paths: Dictionary = {}

# -------------------------------------------------------------------
# Public Path Requests
# -------------------------------------------------------------------

func request_path(
	start_waypoint_id: StringName,
	target_waypoint_id: StringName
) -> Array[StringName]:
	var cache_key := _get_cache_key(
		start_waypoint_id,
		target_waypoint_id
	)

	if cached_paths.has(cache_key):
		return cached_paths[cache_key]

	var path := _run_a_star(
		start_waypoint_id,
		target_waypoint_id
	)

	cached_paths[cache_key] = path

	return path

func invalidate_cached_paths() -> void:
	cached_paths.clear()

# -------------------------------------------------------------------
# A*
# -------------------------------------------------------------------

func _run_a_star(
	start_waypoint_id: StringName,
	target_waypoint_id: StringName
) -> Array[StringName]:
	var frontier: Array[StringName] = [start_waypoint_id]

	var came_from: Dictionary = {}
	var cost_so_far: Dictionary = {}

	came_from[start_waypoint_id] = StringName()
	cost_so_far[start_waypoint_id] = 0.0

	while not frontier.is_empty():
		var current := _pop_lowest_cost(
			frontier,
			cost_so_far,
			target_waypoint_id
		)

		if current == target_waypoint_id:
			break

		var neighbors := _get_connected_waypoints(current)

		for neighbor in neighbors:
			var section_cost := _get_transition_cost(
				current,
				neighbor
			)

			if is_inf(section_cost):
				continue

			var new_cost: float = cost_so_far[current] + section_cost

			if (
				not cost_so_far.has(neighbor)
				or new_cost < cost_so_far[neighbor]
			):
				cost_so_far[neighbor] = new_cost

				came_from[neighbor] = current

				if not frontier.has(neighbor):
					frontier.append(neighbor)

	return _reconstruct_path(
		came_from,
		start_waypoint_id,
		target_waypoint_id
	)

# -------------------------------------------------------------------
# Neighbor Queries
# -------------------------------------------------------------------

func _get_connected_waypoints(
	waypoint_id: StringName
) -> Array[StringName]:
	var waypoint: WaypointDefinition = (
		assault_map_manager.get_waypoint_definition(
			waypoint_id
		)
	)

	var result: Array[StringName] = []

	result.append_array(waypoint.inward_waypoints)
	result.append_array(waypoint.sideways_waypoints)
	result.append_array(waypoint.outward_waypoints)

	return result

# -------------------------------------------------------------------
# Transition Cost
# -------------------------------------------------------------------

func _get_transition_cost(
	from_waypoint_id: StringName,
	to_waypoint_id: StringName
) -> float:
	var section := _find_connecting_section(
		from_waypoint_id,
		to_waypoint_id
	)

	if section == null:
		return INF

	if not assault_map_manager.is_section_traversable(section.id):
		return INF

	var cost := assault_map_manager.get_section_traversal_cost(
		section.id
	)

	var sector_definition: SectorDefinition = (
		assault_map_manager.get_sector_definition(
			section.sector_id
		)
	)

	var sector_state: SectorState = (
		assault_map_manager.get_sector_state(
			section.sector_id
		)
	)

	# Congestion
	cost += sector_state.enemy_strength * 0.1

	# Dangerous sectors
	cost += sector_state.pressure_value * 0.25

	# Open field penalty
	if LayerType.is_open_field(sector_definition.layer):
		cost += 2.0

	return cost

# -------------------------------------------------------------------
# Section Lookup
# -------------------------------------------------------------------

func _find_connecting_section(
	from_waypoint_id: StringName,
	to_waypoint_id: StringName
) -> SectionDefinition:
	var from_waypoint := (
		assault_map_manager.get_waypoint_definition(
			from_waypoint_id
		)
	)

	for section_id in from_waypoint.connected_sections:
		var section := (
			assault_map_manager.get_section_definition(
				section_id
			)
		)

		var matches_forward := (
			section.start_waypoint_id == from_waypoint_id
			and section.end_waypoint_id == to_waypoint_id
		)

		var matches_reverse := (
			section.start_waypoint_id == to_waypoint_id
			and section.end_waypoint_id == from_waypoint_id
		)

		if matches_forward or matches_reverse:
			return section

	return null

# -------------------------------------------------------------------
# Heuristic
# -------------------------------------------------------------------

func _heuristic_cost(
	current_waypoint_id: StringName,
	target_waypoint_id: StringName
) -> float:
	var current := (
		assault_map_manager.get_waypoint_definition(
			current_waypoint_id
		)
	)

	var target := (
		assault_map_manager.get_waypoint_definition(
			target_waypoint_id
		)
	)

	return current.world_position.distance_to(
		target.world_position
	)

# -------------------------------------------------------------------
# Frontier Helpers
# -------------------------------------------------------------------

func _pop_lowest_cost(
	frontier: Array[StringName],
	cost_so_far: Dictionary,
	target_waypoint_id: StringName
) -> StringName:
	var best_index := 0
	var best_score := INF

	for i in frontier.size():
		var waypoint_id := frontier[i]

		var score: float = (
			cost_so_far[waypoint_id]
			+ _heuristic_cost(
				waypoint_id,
				target_waypoint_id
			)
		)

		if score < best_score:
			best_score = score
			best_index = i

	var result := frontier[best_index]

	frontier.remove_at(best_index)

	return result

# -------------------------------------------------------------------
# Path Reconstruction
# -------------------------------------------------------------------

func _reconstruct_path(
	came_from: Dictionary,
	start_waypoint_id: StringName,
	target_waypoint_id: StringName
) -> Array[StringName]:
	if not came_from.has(target_waypoint_id):
		return []

	var current := target_waypoint_id

	var path: Array[StringName] = []

	while current != StringName():
		path.push_front(current)
		current = came_from[current]

	return path

# -------------------------------------------------------------------
# Cache
# -------------------------------------------------------------------

func _get_cache_key(
	start_waypoint_id: StringName,
	target_waypoint_id: StringName
) -> String:
	return "%s:%s" % [
		start_waypoint_id,
		target_waypoint_id
	]
