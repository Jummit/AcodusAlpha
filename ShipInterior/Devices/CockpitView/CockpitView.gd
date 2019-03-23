extends "res://ShipInterior/Devices/Device.gd"

"""
Shows the space outside in 3D projected by a viewport.
"""

onready var ship_camera : ShipCamera = $"../../../../Camera"
onready var camera : = $ViewportContainer/Viewport/Ship/Camera
onready var ship : = $ViewportContainer/Viewport/Ship

var selected : bool setget set_selected, get_selected

func set_selected(v : bool):
	selected = v
	ship_camera.set_process(not selected)

func get_selected() -> bool:
	return selected


func _get_movement_input() -> Vector3:
	var input = Vector3(0, 0, 0)
	
	if Input.is_action_pressed("left"):
		input.x = -1
	elif Input.is_action_pressed("right"):
		input.x = 1
	
	if Input.is_action_pressed("forward"):
		input.z = -1
	elif Input.is_action_pressed("backward"):
		input.z = 1
	
	if Input.is_action_pressed("up"):
		input.y = -1
	elif Input.is_action_pressed("down"):
		input.y = 1
	
	return input


func process_movement_input(input : Vector3):
	input = Transform(self.ship.transform.basis, Vector3(0, 0, 0)).xform(input)
	self.ship.translation += input / 10

func process_rotation_input(input : Vector3):
	input /= 40
	input = -input
	
	self.ship.rotate_object_local(Vector3(1, 0, 0), input.z)
	self.ship.rotate_object_local(Vector3(0, 1, 0), input.x)
	self.ship.rotate_object_local(Vector3(0, 0, 1), input.y)


func _process(delta : float) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		set_selected(false)
	
	if selected:
		var input : Vector3 = _get_movement_input()
		if Input.is_action_pressed("rotation_switch"):
			process_rotation_input(input)
		else:
			process_movement_input(input)


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		set_selected(true)
