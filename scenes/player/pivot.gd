extends Node3D

func _process(_delta):
	# Handle crouch.
	if Input.is_action_pressed("crouch"):
		scale.y = 0.5
	else:
		scale.y = 1.0
