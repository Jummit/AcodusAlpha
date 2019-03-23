extends CanvasLayer

"""
Manages the held item.
"""

func is_holding_item() -> bool:
	return get_child_count() > 0


func get_item() -> Node:
	return get_child(0)


func hold(item : Item) -> void:
	var new_item = item.duplicate()
	new_item.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(new_item)


func drop() -> Item:
	var item = get_item().duplicate()
	item.mouse_filter = Control.MOUSE_FILTER_PASS
	remove_child(get_child(0))
	return item


func _process(delta : float) -> void:
	if is_holding_item():
		get_item().rect_position = get_viewport().get_mouse_position() - Vector2(100, 100)