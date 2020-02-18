tool
extends Node2D

const snap_tolerance = 100.0
const move_smoothing = 9.0

export (Vector2) var clickable_area_extents
export (Vector2) var y_range = Vector2(200.0, 600.0)

var selected: bool = false
onready var target_y_pos: float = y_range.x

func _process(delta):
	if Engine.editor_hint:
		update()
	
	if selected:
		target_y_pos = get_global_mouse_position().y
		target_y_pos = clamp(target_y_pos, y_range.x, y_range.y)
		
		var snap_y_pos: float = y_range.x + (y_range.y - y_range.x)/2.0
		if abs(target_y_pos - snap_y_pos) <= snap_tolerance:
			target_y_pos = snap_y_pos
		
		global_position.y = ((target_y_pos - global_position.y) * move_smoothing * delta) + global_position.y

func _input(event):
	if event.is_action_pressed("g_click"):
		if get_clickable_rect().has_point(to_local(event.global_position)):
			selected = true
	elif event.is_action_released("g_click"):
		selected = false

func _draw():
	if not Engine.editor_hint:
		return

	# clickable area helper
	draw_rect(get_clickable_rect(), Color(0, 1, 0, 0.2))
	
	# slidable area helper
	var slidable_area_helper_width = 50.0
	draw_rect(Rect2( \
		Vector2(-slidable_area_helper_width/2.0, y_range.x - global_position.y), \
		Vector2(slidable_area_helper_width, y_range.y - y_range.x)), \
		Color(1.0, 0.0, 0.0, 0.3) \
	)

func get_clickable_rect() -> Rect2:
	return Rect2(-clickable_area_extents/2.0, clickable_area_extents)
