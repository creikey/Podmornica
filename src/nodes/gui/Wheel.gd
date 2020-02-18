tool
extends Node2D

const turn_smoothing = 25.0
const snap_range = 10.0
const angle_range = 60.0

export var select_radius: float = 100.0

var selected: bool = false
var target_rotation: float = 0.0

func _process(delta):
	if Engine.editor_hint:
		update()
		return
	
	if selected:
		target_rotation = global_position.angle_to_point(get_global_mouse_position()) - PI/2.0
		target_rotation = clamp(target_rotation, -deg2rad(angle_range), deg2rad(angle_range))
		
		if abs(target_rotation) < deg2rad(snap_range):
			target_rotation = 0.0

	# global_position.y = ((target_y_pos - global_position.y) * move_smoothing * delta) + global_position.y
	rotation = ((target_rotation - rotation) * turn_smoothing * delta) + rotation

func _input(event):
	if event.is_action_pressed("g_click"):
		if global_position.distance_to(get_global_mouse_position()) <= select_radius:
			selected = true
	elif event.is_action_released("g_click"):
		selected = false

func _draw():
	if not Engine.editor_hint:
		return
	
	draw_circle(Vector2(), select_radius, Color(0, 1, 0, 0.2))
