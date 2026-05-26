class_name DefenseState
extends RefCounted

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
