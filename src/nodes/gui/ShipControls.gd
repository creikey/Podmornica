extends PanelContainer

const player_state = preload("res://player_state.tres")

func _input(event):
	if event.is_action_pressed("g_toggle_controls"):
		if player_state.energy <= 1.0:
			return
		visible = !visible
		player_state.viewing_controls = visible
