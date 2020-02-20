extends Node2D

const player_state = preload("res://player_state.tres")

func _ready():
	randomize()

func _process(delta):
	var camera_shake: Vector2 = Vector2(rand_range(-20.0, 20.0), rand_range(-20.0, 20.0))*player_state.camera_shake_amount
	$UI.offset = camera_shake
	$Player/Camera2D.offset = camera_shake
