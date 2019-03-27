extends "res://Objects/Object/Object.gd"

"""
Can be used to pilot the spation the computer is on around.

Select by clicking, deselect by hitting escape. Use arrow keys to move around, hold shift to switch rotation mode.
"""

onready var player : KinematicBody2D = $"/root/Main/Player"
var selected : bool = false


func _get_movement_input() -> Vector3:
	var input : Vector3 = Vector3(0, 0, 0)
	
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


func _process(delta : float) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		selected = false
		player.set_process(true)
	
	if selected:
		var input : Vector3 = _get_movement_input()
		if Input.is_action_pressed("rotation_switch"):
			station.do_rotation(input)
		else:
			station.do_move(input)


func _on_clicked():
	if !$"/root/HeldItem".is_holding_item():
		selected = true
		player.set_process(false)