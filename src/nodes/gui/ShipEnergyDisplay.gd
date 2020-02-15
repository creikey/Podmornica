extends HBoxContainer

const player_state = preload("res://player_state.tres")

func _process(delta):
	$ProgressBar.value = player_state.energy
