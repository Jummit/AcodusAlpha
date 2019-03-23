extends Sprite

"""
A device that can be placed in a room

Used to create all kinds of devices, for examples farming plots, screens, furniture and more.
"""

func _on_clicked() -> void:
	pass


func _on_input_event(viewport, event, shape_idx) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		_on_clicked()
