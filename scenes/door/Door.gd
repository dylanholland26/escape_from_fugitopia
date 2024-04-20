extends AnimatableBody3D


var is_open = false

func toggle():
	if not is_open:
		open()
	else:
		close()

func open():
	if not is_open and not $AnimationPlayer.is_playing():
		$AnimationPlayer.play("Open")
		is_open = true
	
func close():
	if is_open and not $AnimationPlayer.is_playing():
		$AnimationPlayer.play_backwards("Open")
		is_open = false
