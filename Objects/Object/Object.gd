extends Sprite

"""
Objects can be furniture, machines and many other things

Emits the 'clicked' signal when being interacted with.
"""


signal clicked

onready var station : Station = $"../../../"


func _on_input_event(viewport : Viewport, event : InputEvent, shape_idx : int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		emit_signal("clicked")
