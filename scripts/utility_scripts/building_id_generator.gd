# building_id_generator.gd
class_name BuildingIdGenerator
extends RefCounted

var next_id: int = 1

func generate() -> int:
	var id := next_id
	next_id += 1
	return id
