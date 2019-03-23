extends "res://ShipInterior/Devices/Device.gd"

"""
Shows the space outside in 3D projected by a viewport.
"""

onready var ship_camera : ShipCamera = $"../../../../Camera"
onready var camera : = $ViewportContainer/Viewport/Ship/Camera
onready var ship : = $ViewportContainer/Viewport/Ship

var selected : bool = false

func _process(delta : float) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		ship_camera.set_process(true)
	
	var movement : Vector3 = Vector3(0, 0, 0)
	var rotation_movement : Vector2 = Vector2(0, 0)
	
	if Input.is_key_pressed(KEY_A):
		rotation_movement.x = 1
	elif Input.is_key_pressed(KEY_D):
		rotation_movement.x = -1
	if Input.is_key_pressed(KEY_W):
		movement.z = -1
	elif Input.is_key_pressed(KEY_S):
		movement.z = 1
	if Input.is_key_pressed(KEY_Q):
		rotation_movement.y = 1
	elif Input.is_key_pressed(KEY_E):
		rotation_movement.y = -1
	
	movement = movement / 10
	movement = movement.rotated(Vector3(1, 0, 0), ship.rotation.x)
	movement = movement.rotated(Vector3(0, 1, 0), ship.rotation.y)
	
	rotation_movement = rotation_movement / 50
	
	ship.rotation.y += rotation_movement.x
	ship.rotation.x += rotation_movement.y
	
	ship.translation += movement

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		selected = true
		ship_camera.set_process(false)
