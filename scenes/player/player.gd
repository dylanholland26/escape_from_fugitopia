extends CharacterBody3D

@export var inventory_data: InventoryData
signal toggle_inventory()
@onready var interact_ray = $Pivot/PlayerCamera/View

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const MOUSE_SENSITIVITY = 0.002
#const RAY_LENGTH = 100.0

var is_locked = false

var focus = null:
	set(obj):
		if focus:
			if focus.has_method("look_away"):
				focus.look_away()
		if obj:
			if obj.has_method("look"):
					obj.look()
		focus = obj
		

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	if not is_locked:
		# Detect object in front
		if $Pivot/PlayerCamera/View.is_colliding():
			var obj = $Pivot/PlayerCamera/View.get_collider()
			if focus != obj:
				focus = obj
		elif focus:
			focus = null
			
		# Add the gravity.
		if not is_on_floor():
			velocity.y -= gravity * delta

		# Handle jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)

		move_and_slide()
	
func _input(event):
	if not is_locked:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				if focus:
					if focus.has_method("click"):
						focus.click()
	
func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		$Pivot.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -1.2, 1.2)
		
	if Input.is_action_just_pressed("pickup"):
		interact()
	
	if Input.is_action_just_pressed("inventory"):
		#toggle_inventory.emit()
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		

func interact():
	if interact_ray.is_colliding():
		interact_ray.get_collider().player_interact()
	
func lock_controls():
	is_locked = true
	
func unlock_controls():
	is_locked = false
	