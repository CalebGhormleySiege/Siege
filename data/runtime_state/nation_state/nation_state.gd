class_name NationState
extends RefCounted

var prosperity := 0.0
var stability := 0.0
var war_support := 0.0

# Each Nation has 3 Military Chapters
var chapter_states : Dictionary[StringName, FactionState]
# Each Nation has 3 Cilian Guilds
var guild_states : Dictionary[StringName, FactionState]
# Each Nation has 2 Minor Allied Nations
var allied_nation_states : Dictionary[StringName, MinorNationState]
