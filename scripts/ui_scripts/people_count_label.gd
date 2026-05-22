extends Control

@onready var SoldiersCountLabel: Label = $MarginContainer/GridContainer/LeftColumnGridContainer/SoldiersCountLabel
@onready var CommandersCountLabel: Label = $MarginContainer/GridContainer/LeftColumnGridContainer/CommandersCountLabel
@onready var CitizensCountLabel: Label = $MarginContainer/GridContainer/RightColumnGridContainer/CitizensCountLabel
@onready var EngineersCountLabel: Label = $MarginContainer/GridContainer/RightColumnGridContainer/EngineersCountLabel

func _ready():
	GameManager.population_changed.connect(update_labels)
	update_labels()

func update_labels():
	SoldiersCountLabel.text = "%d/%d" % [ 0 , GameManager.soldiers.size()]
	CommandersCountLabel.text = "%d/%d" % [ 0 , GameManager.commanders.size()]
	CitizensCountLabel.text = "%d/%d" % [ 0 , GameManager.citizens.size()]
	EngineersCountLabel.text = "%d/%d" % [ 0 , GameManager.engineers.size()]
