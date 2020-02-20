extends Sprite

const player_state = preload("res://player_state.tres")

export (OpenSimplexNoise) var bob_noise

var time: float = 0.0
onready var initial_y: float = global_position.y


func _process(delta):
	time += delta
	rotation = player_state.rotation
	global_position.y = initial_y + bob_noise.get_noise_1d(time*10.0)*70.0
