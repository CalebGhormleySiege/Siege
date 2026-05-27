class_name DefenseState
extends RefCounted

var id: String = ""

# Which AssaultMapGraph Sections the defense can reach 
# Calculated when placed and recalculated on upgrade
# Range, facing, and placement determine candidates
@export var candidate_section_ids: Array[StringName]

var position: Vector2
var facing: Vector2

var range_length: float
var range_width: float

var fire_interval: float
var damage_profile

func serialize() -> Dictionary:
	return {
		"id": id,
		"candidate_section_ids": candidate_section_ids,
		"position": position,
		"facing": facing,
		"range_length": range_length,
		"range_width": range_width,
		"fire_interval": fire_interval
		# Note: damage_profile may need custom serialization depending on its type
	}

func deserialize(data: Dictionary) -> void:
	id = data.get("id", "")
	candidate_section_ids = data.get("candidate_section_ids", [])
	position = data.get("position", Vector2.ZERO)
	facing = data.get("facing", Vector2.RIGHT)
	range_length = data.get("range_length", 0.0)
	range_width = data.get("range_width", 0.0)
	fire_interval = data.get("fire_interval", 0.0)
	# Note: damage_profile restoration may require additional logic
