extends CanvasLayer

@onready var food_label: Label = $Control/Panel/VBoxContainer/FoodHBox/Label
@onready var wood_label: Label = $Control/Panel/VBoxContainer/WoodHBox/Label
@onready var stone_label: Label = $Control/Panel/VBoxContainer/StoneHBox/Label
@onready var relief_label: Label = $Control/Panel/VBoxContainer/ReliefHBox/Label
@onready var unassigned_label: Label = $Control/Panel/VBoxContainer/UnassignedHBox/Label

func _ready() -> void:
	GameManager.resources_changed.connect(update_ui)
	GameManager.population_changed.connect(update_ui)
	update_ui()

func update_ui() -> void:
	food_label.text = "Food: " + str(GameManager.food)
	wood_label.text = "Wood: " + str(GameManager.wood)
	stone_label.text = "Stone: " + str(GameManager.stone)
	relief_label.text = "Relief in: " + str(GameManager.days_until_relief) + " days"
	var unassigned_count = GameManager.get_unassigned_citizens().size()
	unassigned_label.text = "Unassigned: " + str(unassigned_count)

func _on_assign_food_pressed() -> void:
	if GameManager.assign_job("food"):
		print("Assigned citizen to food production")
	update_ui()

func _on_assign_wood_pressed() -> void:
	if GameManager.assign_job("wood"):
		print("Assigned citizen to wood production")
	update_ui()

func _on_assign_stone_pressed() -> void:
	if GameManager.assign_job("stone"):
		print("Assigned citizen to stone production")
	update_ui()
