class_name MinorNationDefinition
extends Resource

@export var id : StringName
@export var display_name : String

@export var ideologies : Array[Enums.Ideology]

@export var supply_table : Array[SupplyRewardData]

@export var base_request_cooldown_days := 20.0
@export var base_support_decay := 5.0

@export var color : Color
@export var emblem : Texture2D
