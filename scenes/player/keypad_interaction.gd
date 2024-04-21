extends RayCast3D

#var hints_used : int
var current_collider: Object
#@onready var interaction_label = get_node("/root/main/UI/HintLabel")

#func _ready():
	#hints_used = 0
	#set_interaction_text("")

func _process(_delta):
	var collider = get_collider()
	if is_colliding() and collider is Interactable:
		if current_collider != collider:
			#set_interaction_text(collider.get_interaction_text())
			current_collider = collider

		if Input.is_action_just_pressed("interact"):
			current_collider.interact()
			#set_interaction_text(collider.get_interaction_text())
	elif is_instance_valid(current_collider):
		current_collider = null
		#set_interaction_text("")
	pass

#func set_interaction_text():
	#if hints_used == 0:
		#interaction_label.text = "Hint: It could be small... look closely!"
	#elif hints_used == 1:
		#interaction_label.text = "Hint: Do you have the key to the ciphers?"
	#elif hints_used == 2:
		#interaction_label.text = "Hint: The ciphers reveal the passcode"
	#hints_used += 1
