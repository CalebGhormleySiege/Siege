class_name FactionDefinition
extends Resource

@export var id : StringName
@export var display_name : String
@export var faction_type : Enums.FactionType

@export var ideologies : Array[Enums.Ideology]

@export var modifiers : FactionModifiers

@export var portrait : Texture2D
@export var color : Color
