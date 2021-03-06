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

const rotation_smoothing = 8.0
const max_horizontal_velocity = 400.0
const max_vertical_velocity = 400.0

var accel: Vector2 = Vector2()
var vel: Vector2 = Vector2()
var shake: float = 0.0

func _ready():
	player_state.controls = Vector2()
	player_state.rotation_controls = 0.0
	player_state.energy = 100.0
	player_state.health = 100.0
	player_state.viewing_controls = true
	player_state.rotation = 0.0
	player_state.vel = Vector2()
	randomize()

func _process(delta):
	var cur_energy_rate: float = energy_rate_nothrust
	
	if player_state.controls.length() > 1.0:
		cur_energy_rate = energy_rate_thrust
	
	if not player_state.viewing_controls:
		cur_energy_rate = energy_rate_viewing
	
	player_state.energy += cur_energy_rate*delta
	player_state.energy = clamp(player_state.energy, 0.0, 100.0)
	
	player_state.camera_shake_amount = shake

func _physics_process(delta):
	
	rotation = ((player_state.rotation_controls*deg2rad(30.0) - rotation) * rotation_smoothing * delta) + rotation
	
	player_state.rotation = rotation
	
	accel = player_state.controls * 50.0
	
	accel = accel.rotated(rotation)
	
#	if accel.x > 0.0:
#		$Sprite.flip_h = false
#		$CollisionPolygon2D.scale.x = 1.0
#	if accel.x < 0.0:
#		$Sprite.flip_h = true
#		$CollisionPolygon2D.scale.x = -1.0
	
	vel += accel*delta

	vel = move_and_slide(vel)

	player_state.vel = vel

	# crash detection
	for i in range(get_slide_count()):
		var intensity: float = get_slide_collision(i).travel.length()
		if intensity >= 1.2 and $LastCrashTimer.is_stopped():
			$LastCrashTimer.start()
			$ShakeTween.interpolate_property(self, "shake", 1.0, 0.0, 1.5, Tween.TRANS_CUBIC, Tween.EASE_IN)
			$ShakeTween.start()
			
			player_state.health -= intensity*5.0
				
			vel = get_slide_collision(i).normal.normalized()*vel.length()
			
			$MultiPlayer.play(crashes[randi()%crashes.size()])

	vel.x = clamp(vel.x, -max_horizontal_velocity, max_horizontal_velocity)
	vel.y = clamp(vel.y, -max_vertical_velocity, max_vertical_velocity)
	
	if player_state.health <= 0.1:
		get_tree().change_scene("res://Lose.tscn")
