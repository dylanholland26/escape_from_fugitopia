extends Node

const PickUp = preload("res://item/pick_up/pickup.tscn")

@onready var player = $Player
@onready var inventory_interface = $UI/InventoryInterface
@onready var clue_1 = $"Clue#1"
@onready var door = $door


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_viewport().set_input_as_handled()
	
	player.toggle_inventory.connect(toggle_inventory_interface)
	inventory_interface.set_player_inventory_data(player.inventory_data)
	
	for node in get_tree().get_nodes_in_group("external_inventory"):
		node.toggle_inventory.connect(toggle_inventory_interface)
		
	
func toggle_inventory_interface(external_inventory_owner = null) -> void:
	inventory_interface.visible = not inventory_interface.visible
	if inventory_interface.visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if external_inventory_owner and inventory_interface.visible:
		inventory_interface.set_external_inventory(external_inventory_owner)
	else:
		inventory_interface.clear_external_inventory()
		
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_viewport().set_input_as_handled()
	if event.is_action_pressed("click"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			get_viewport().set_input_as_handled()

func _on_button_pressed():
	# going to change this
	$Door.toggle()


func _on_sprout_controller_player_detected():
	$Player.lock_controls()



func _on_ui_dropping_item(slot_data):
	print("trying")
	var pick_up = PickUp.instantiate()
	pick_up.slot_data = slot_data
	pick_up.position = Vector3.UP
	add_child(pick_up)
	


func _on_timer_timeout():
	clue_1.visible = true


func _on_keypad_on_correct_password():
	print("correct password")
	door.open()


func _on_keypad_on_wrong_password():
	print("incorrect password")
	door.close()
