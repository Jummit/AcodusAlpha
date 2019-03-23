extends "res://ShipInterior/Devices/Device.gd"

"""
Shows the space outside in 3D projected by a viewport.
"""

onready var ship_camera : ShipCamera = $"../../../../Camera"
onready var camera : = $ViewportContainer/Viewport/Ship/Camera
onready var ship : = $ViewportContainer/Viewport/Ship

var selected : bool setget set_selected, get_selected

class MovementInput:
	var movement : Vector3
	var rotation : Vector3
	func _init(movement : Vector3, rotation : Vector3):
		self.movement = movement
		self.rotation = rotation

func set_selected(v : bool):
	selected = v
	ship_camera.set_process(not selected)

func get_selected() -> bool:
	return selected


func _get_movement_input() -> MovementInput:
	var input : MovementInput = MovementInput.new(Vector3(0, 0, 0), Vector3(0, 0, 0))
	
	if Input.is_key_pressed(KEY_A):
		input.rotation.x = 1
	elif Input.is_key_pressed(KEY_D):
		input.rotation.x = -1
	
	if Input.is_key_pressed(KEY_Q):
		input.rotation.y = 1
	elif Input.is_key_pressed(KEY_E):
		input.rotation.y = -1
	
	if Input.is_key_pressed(KEY_W):
		input.movement.z = -1
	elif Input.is_key_pressed(KEY_S):
		input.movement.z = 1
	
	return input


func process_movement_input(input : MovementInput):
	# setup movement
	input.movement /= 10
	input.movement = input.movement.rotated(Vector3(1, 0, 0), ship.rotation.x)
	input.movement = input.movement.rotated(Vector3(0, 1, 0), ship.rotation.y)
	
	input.rotation /= 50
	
	# move and rotate ship
	ship.rotation.y += input.rotation.x
	ship.rotation.x += input.rotation.y
	
	ship.translation += input.movement


func _process(delta : float) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		set_selected(false)
	
	if selected:
		process_movement_input(_get_movement_input())


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		set_selected(true)
