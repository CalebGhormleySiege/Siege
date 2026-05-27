# people_state.gd
class_name PeopleState
extends RefCounted

var id: String = ""

# Population statistics
var total_population: int = 0
var employed_count: int = 0
var unemployed_count: int = 0

# Morale and happiness
var morale: float = 50.0
var happiness: float = 50.0

# Health and sickness
var average_health: float = 100.0
var sickness_level: float = 0.0

# Growth
var birth_rate: float = 0.0
var death_rate: float = 0.0

func serialize() -> Dictionary:
	return {
		"id": id,
		"total_population": total_population,
		"employed_count": employed_count,
		"unemployed_count": unemployed_count,
		"morale": morale,
		"happiness": happiness,
		"average_health": average_health,
		"sickness_level": sickness_level,
		"birth_rate": birth_rate,
		"death_rate": death_rate
	}

func deserialize(data: Dictionary) -> void:
	id = data.get("id", "")
	total_population = data.get("total_population", 0)
	employed_count = data.get("employed_count", 0)
	unemployed_count = data.get("unemployed_count", 0)
	morale = data.get("morale", 50.0)
	happiness = data.get("happiness", 50.0)
	average_health = data.get("average_health", 100.0)
	sickness_level = data.get("sickness_level", 0.0)
	birth_rate = data.get("birth_rate", 0.0)
	death_rate = data.get("death_rate", 0.0)
