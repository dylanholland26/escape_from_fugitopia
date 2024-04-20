extends Path3D

func _physics_process(delta: float) -> void:
	const move_speed = 1.0
	$PathFollow3D.progress += move_speed * delta
