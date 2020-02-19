extends Node2D

const player_state = preload("res://player_state.tres")

func _input(event):
	if event.is_action_pressed("g_toggle_controls"):
		if player_state.energy <= 1.0:
			return
		player_state.viewing_controls = !player_state.viewing_controls

func _process(delta):
	visible = player_state.viewing_controls

	if player_state.energy <= 1.0:
		player_state.viewing_controls = true
	
	player_state.controls.x = $LeftSlider.value
	player_state.controls.y = $RightSlider.value
	player_state.controls.y *= -1.0 # up should be up
#	print(player_state.controls)
	player_state.rotation_controls = $Wheel.value
