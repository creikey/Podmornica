extends KinematicBody2D

var vel: Vector2 = Vector2()

func _physics_process(delta):
	var move: Vector2 = Vector2(
		int(Input.is_key_pressed(KEY_D)) - int(Input.is_key_pressed(KEY_A)),
		int(Input.is_key_pressed(KEY_S)) - int(Input.is_key_pressed(KEY_W))
	)

	vel = move*300.0

	vel = move_and_slide(vel)
