extends PanelContainer

func _input(event):
	if event.is_action_pressed("g_toggle_controls"):
		visible = !visible
