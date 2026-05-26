class_name NationDefinition
extends Resource

@export var id : StringName
@export var display_name : String

@export var primary_color : Color
@export var secondary_color : Color

@export var chapters : Array[FactionDefinition]
@export var guilds : Array[FactionDefinition]

@export var allied_minor_nations : Array[MinorNationDefinition]
