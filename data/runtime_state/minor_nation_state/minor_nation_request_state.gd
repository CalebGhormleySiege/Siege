class_name MinorNationRequestState
extends RefCounted

var request_id : StringName

var request_type : StringName
# "food"
# "military"
# "industry"
# "honor"
# etc

var progress := 0.0
var required_progress := 100.0

var remaining_days := 0.0

var reward_strength := 1.0

var fulfilled := false
