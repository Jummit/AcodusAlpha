extends "res://ShipInterior/Devices/Device.gd"

"""
A container stores items

Containers are used to make machines and storage devices. You can move items from container to container.
"""

onready var held_item = $"/root/HeldItem"
onready var slots = $Slots


func register_item(item : Item) -> void:
	item.connect("gui_input", self, "_on_item_gui_input", [item])


func _ready():
	for item in slots.get_children():
		register_item(item)


func _on_item_gui_input(event : InputEvent, item : Item):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		if not held_item.is_holding_item():
			held_item.hold(item)
			slots.remove_child(item)


func _on_clicked() -> void:
	if held_item.is_holding_item():
		var item : Item = held_item.drop()
		slots.add_child(item)
		register_item(item)
