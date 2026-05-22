extends Person
class_name Soldier

@export var attack_range: float = 50.0
@export var attack_damage: float = 10.0
@export var attack_cooldown: float = 1.0

var target_enemy: Node2D = null
var can_attack: bool = true

func _ready() -> void:
	super._ready()
	current_job = "soldier"
	# Add soldier to GameManager if needed, though soldiers are usually converted citizens
	# For now let's just make sure they are tracked if they spawn as soldiers
	# If they were citizens before, they might need to be removed from citizens list.
	if self is Node2D:
		# Soldiers in this game might be a separate population or just citizens with a job.
		# Given the current GameManager structure, let's keep them separate for now.
		pass

func _physics_process(delta: float) -> void:
	if target_enemy:
		var dist: float = global_position.distance_to(target_enemy.global_position)
		if dist <= attack_range:
			attack()
		else:
			target_pos = target_enemy.global_position
			set_movement_target(target_pos)
	
	super._physics_process(delta)

func attack() -> void:
	if can_attack and target_enemy:
		# Attack logic here
		can_attack = false
		await get_tree().create_timer(attack_cooldown).timeout
		can_attack = true
