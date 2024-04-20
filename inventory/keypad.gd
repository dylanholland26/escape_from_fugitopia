extends Node3D

@export var correct_password = "653"

var password = ""

signal on_correct_password
signal on_wrong_password
signal on_clear_password
signal on_keypad_press

@onready var keys = $Keys
@onready var password_label = $PasswordViewport/PasswordLabel

func _ready():
	for child in keys.get_children():
		if child is StaticBody3D:
			child.connect("on_interact", Callable(self, "on_button_interact"))

	password_label.text = ""

func on_button_interact(value):
	print("interacted with " + value)

	# enter key is pressed
	if value == ".":
		# check if the number is the correct number
		if password == correct_password:
			on_correct_password.emit()
			#emit_signal("on_correct_password", password)
		else:
			on_wrong_password.emit()
		password = ""

	# clear key is pressed
	elif value == "C":
		# clear the current number
		on_clear_password.emit()
		password = ""

	# digit key is pressed
	else:
		# got a number value
		if password.length() == correct_password.length():
			return
		password += value
		on_keypad_press.emit()

	password_label.text = password


