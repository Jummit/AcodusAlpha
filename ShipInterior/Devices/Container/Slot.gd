extends CenterContainer

"""
A slot which can contain an item.

Items can be put into or pulled out of slots.
When clicking with an item on a full slot, items will be switched.
"""

onready var held_item = $"/root/HeldItem"


func get_item() -> Node:
	return get_child(0)


func clear() -> void:
	remove_child(get_item())


func _on_gui_input(event : InputEvent):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		var empty : bool = get_item() != null
		var holding_item : bool = held_item.is_holding_item()
		if !holding_item and empty:
			held_item.hold(get_item())
			clear()
		elif holding_item and !empty:
			add_child(held_item.drop())
		elif holding_item and empty:
			# save item since we will remove the original before we give it to held_item
			var item : Item = get_item()
			clear()
			add_child(held_item.drop())
			held_item.hold(item)
