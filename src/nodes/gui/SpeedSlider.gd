extends VBoxContainer

const player_state = preload("res://player_state.tres")

func _process(delta):
	player_state.controls.x = $HSlider.value
