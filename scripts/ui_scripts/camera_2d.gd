extends Camera2D

var target: Node2D = null
var free_move := true

func _process(_delta):
	if target and not free_move:
		global_position = target.global_position
		
func set_follow_target(node: Node2D):
	target = node
	free_move = false

func clear_follow_target():
	target = null
	free_move = true

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		clear_follow_target()
