class_name MinorNationState
extends RefCounted

# 0-100 willingness to assist player
var siege_support := 50.0

# Time until next request can occur
var request_cooldown_days := 0.0

# Current ideological request
var active_request : MinorNationRequestState

var completed_requests := 0
var failed_requests := 0

var total_supplies_sent := 0
