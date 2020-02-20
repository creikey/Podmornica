extends ProgressBar

const player_state = preload("res://player_state.tres")

func _process(delta):
	value = player_state.health
