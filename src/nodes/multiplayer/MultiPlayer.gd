extends Node2D

func play(path: String):
	for n in get_children():
		if not n.playing:
			n.stream = load(path)
			n.play()
			return
