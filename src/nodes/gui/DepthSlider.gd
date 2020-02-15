extends HBoxContainer

const player_state = preload("res://player_state.tres")

func _process(delta):
	player_state.controls.y = -$VSlider.value
