extends Label

const player_state = preload("res://player_state.tres")

func _process(delta):
	text = str("velocity: ", stepify(player_state.vel.x, 0.1), ", ", stepify(player_state.vel.y*-1.0, 0.1))
