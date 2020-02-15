extends KinematicBody2D

const player_state = preload("res://player_state.tres")

const energy_rate_nothrust = 5.0
const energy_rate_thrust = -1.0
const energy_rate_viewing = -10.0

const max_horizontal_velocity = 400.0
const max_vertical_velocity = 400.0

var accel: Vector2 = Vector2()
var vel: Vector2 = Vector2()

func _process(delta):
	var cur_energy_rate: float = energy_rate_nothrust
	
	if player_state.controls.length() > 1.0:
		cur_energy_rate = energy_rate_thrust
	
	if not player_state.viewing_controls:
		cur_energy_rate = energy_rate_viewing
	
	player_state.energy += cur_energy_rate*delta

func _physics_process(delta):
	
	accel = player_state.controls
	
	vel += accel*delta

	vel = move_and_slide(vel)

	vel.x = clamp(vel.x, -max_horizontal_velocity, max_horizontal_velocity)
	vel.y = clamp(vel.y, -max_vertical_velocity, max_vertical_velocity)
