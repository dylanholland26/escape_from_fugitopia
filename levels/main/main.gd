extends Node

const PickUp = preload("res://item/pick_up/pickup.tscn")
const MARKET = preload("res://levels/market_level/market.tscn")
#var market_instance = MARKET.instantiate()

@onready var player = $Player
@onready var inventory_interface = $UI/InventoryInterface
@onready var clue_1 = $"Clue#1"
@onready var door = $door

@onready var enemy = $ENEMY
@onready var enemy2 = $ENEMY2
@onready var hint_label = $UI/HintLabel


func _ready():
	#get_tree().change_scene_to_file("res://levels/market_level/market.tscn")
	
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

	var pick_up = PickUp.instantiate()
	pick_up.slot_data = slot_data
	pick_up.position = Vector3.UP
	add_child(pick_up)
	


func _on_timer_timeout():
	pass
	#clue_1.visible = true


func _on_keypad_on_correct_password():
	print("correct password")
	door.open()
	hint_label.text = "Current Objective: Avoid the guards!"


func _on_keypad_on_wrong_password():
	print("incorrect password")
	door.close()


func _on_button_2_pressed():
	clue_1.visible = true
	hint_label.text = "Press K once you have picked up the scroll."
