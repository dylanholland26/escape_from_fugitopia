extends CharacterBody3D

signal player_detected
signal text_written

var is_activated = false
var player = null
func _process(delta):
	if is_activated:
		var target_vector = global_position.direction_to(player.position)
		var target_basis = Basis.looking_at(-target_vector)
		basis = basis.slerp(target_basis, 0.5)
		var player_loc = player.position + (player.position.direction_to(position)) * 2.0
		position = position.move_toward(player_loc, delta)
func _on_player_detection_area_body_entered(body):
	if body.is_in_group("player"):
		is_activated = true
		player = body
		text_written.emit("Pssst. Hey you keep your voice down, I'm trying not to be noticed here.")
		text_written.emit("What are you even doing in the market this late at night?")
		text_written.emit("There's no time, it sounds like someone heard us!")
		player_detected.emit()



func _on_text_finished():
	if is_activated:
		get_tree().change_scene_to_file("res://levels/main/main.tscn")
