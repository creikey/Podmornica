extends KinematicBody2D

const player_state = preload("res://player_state.tres")

const crashes = [
	"res://nodes/player/crashes/1.wav",
	"res://nodes/player/crashes/2.wav",
	"res://nodes/player/crashes/3.wav",
	"res://nodes/player/crashes/4.wav",
	"res://nodes/player/crashes/5.wav",
]

const energy_rate_nothrust = 5.0
const energy_rate_thrust = -1.0
const energy_rate_viewing = -10.0

const max_horizontal_velocity = 400.0
const max_vertical_velocity = 400.0

var accel: Vector2 = Vector2()
var vel: Vector2 = Vector2()

func _ready():
	randomize()

func _process(delta):
	var cur_energy_rate: float = energy_rate_nothrust
	
	if player_state.controls.length() > 1.0:
		cur_energy_rate = energy_rate_thrust
	
	if not player_state.viewing_controls:
		cur_energy_rate = energy_rate_viewing
	
	player_state.energy += cur_energy_rate*delta
	player_state.energy = clamp(player_state.energy, 0.0, 100.0)

func _physics_process(delta):
	
	accel = player_state.controls * 2.0
	
	if accel.x > 0.0:
		$Sprite.flip_h = false
		$CollisionPolygon2D.scale.x = 1.0
	if accel.x < 0.0:
		$Sprite.flip_h = true
		$CollisionPolygon2D.scale.x = -1.0
	
	vel += accel*delta

	vel = move_and_slide(vel)

	# crash detection
	for i in range(get_slide_count()):
		var intensity: float = get_slide_collision(i).travel.length()
		if intensity >= 1.2 and $LastCrashTimer.is_stopped():
			$LastCrashTimer.start()
			
			player_state.health -= intensity*5.0
			
			vel = get_slide_collision(i).normal.normalized()*vel.length()
			
			$MultiPlayer.play(crashes[randi()%crashes.size()])

	vel.x = clamp(vel.x, -max_horizontal_velocity, max_horizontal_velocity)
	vel.y = clamp(vel.y, -max_vertical_velocity, max_vertical_velocity)
