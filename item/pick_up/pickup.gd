extends RigidBody3D

@export var slot_data: SlotData
@onready var sprite_3d = $Sprite3D


# Called when the node enters the scene tree for the first time.
func _ready():
	sprite_3d.texture = slot_data.item_data.texture
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	sprite_3d.rotate_y(delta)	


func _on_area_3d_body_entered(body):
	print("body entered", body)
	if body is CharacterBody3D:
		if body.inventory_data.pick_up_slot_data(slot_data):
			queue_free()
	
