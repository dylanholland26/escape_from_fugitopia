extends CanvasLayer

signal text_finished
signal dropping_item

@onready var textbox = $MarginContainer/UIArea/TextBox

func _on_text_written(next_text):
	queue_text(next_text)
	
	
func queue_text(next_text):
	textbox.queue_text(next_text)


func _on_text_finished():
	text_finished.emit()


func _on_inventory_interface_drop_slot_data(slot_data):
	print("midway")
	dropping_item.emit()
