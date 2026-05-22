extends Node2D

@export var move_speed: int = 600
@export var zoom_step: float = 0.1
@export var min_zoom: float = 0.5
@export var max_zoom: float = 2.0


enum InputMode { SELECT, BUILD, FOLLOW }
var current_mode: InputMode = InputMode.SELECT

var camera: Camera2D = null

func _process(delta):
	if current_mode == InputMode.SELECT or current_mode == InputMode.BUILD:
		handle_camera_movement(delta)

func handle_camera_movement(delta):
	if not camera:
		return
	
	var input := Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()

	if input.length_squared() > 0.0:
		camera.position += input * move_speed * delta
		
func set_camera_reference(cam: Camera2D) -> void:
	camera = cam

func _unhandled_input(event: InputEvent):
	# Skip input if modal UI is active
	if event.is_echo():
		return

	if get_viewport().gui_get_focus_owner() != null:
		return  # Focused text field etc.

	#if event is InputEventMouseButton and event.pressed:
		#if event.is_handled():
			#return  # UI handled the click
			
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			MOUSE_BUTTON_WHEEL_DOWN:
				zoom_camera(-zoom_step)
			MOUSE_BUTTON_WHEEL_UP:
				zoom_camera(zoom_step)
		
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var clicked = get_player_at_mouse()
		if clicked:
			camera.call("set_follow_target", clicked)
		else:
			camera.call("clear_follow_target")

func zoom_camera(delta: float) -> void:
	var new_zoom = camera.zoom + Vector2(delta, delta)
	new_zoom.x = clamp(new_zoom.x, min_zoom, max_zoom)
	new_zoom.y = clamp(new_zoom.y, min_zoom, max_zoom)
	camera.zoom = new_zoom

func get_player_at_mouse() -> Node2D:
	var mouse_pos: Vector2 = get_global_mouse_position()
	
	var params := PhysicsPointQueryParameters2D.new()
	params.position = mouse_pos
	params.collide_with_areas = true
	params.collide_with_bodies = true
	params.collision_mask = 0xFFFFFFFF  # or set to specific mask if needed
	
	var space_state = get_world_2d().direct_space_state
	var results = space_state.intersect_point(params, 10)  # max results

	for result in results:
		var collider = result.collider
		if collider and collider.is_in_group("player"):
			return collider

	return null
