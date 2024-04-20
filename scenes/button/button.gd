extends StaticBody3D

signal pressed

func _ready():
	$Mesh/Base/Highlight.hide()
	$Mesh/Button/Highlight.hide()

func look():
	$Mesh/Base/Highlight.visible = true
	$Mesh/Button/Highlight.visible = true
	
func look_away():
	$Mesh/Base/Highlight.visible = false
	$Mesh/Button/Highlight.visible = false

func click():
	$Mesh/AnimationPlayer.play("Press")
	pressed.emit()
