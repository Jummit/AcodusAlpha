extends Camera2D

signal room_switched(room_name)

"""
The camera viewing the spaceship rooms

Switches rooms when wasd-keys are pressed.

Notes
-----
Uses a procedural animation for the movement.
"""

onready var rooms : Array = [
		[$"../Rooms/Living", $"../Rooms/Cockpit"],
		[$"../Rooms/Engines", $"../Rooms/Working"]]
onready var animation_player : = $AnimationPlayer

var current_room_position : = Vector2(0, 0)


func _get_movement_input() -> Vector2:
	var movement : Vector2 = Vector2(0, 0)
	
	if Input.is_key_pressed(KEY_A):
		movement.x = -1
	elif Input.is_key_pressed(KEY_D):
		movement.x = 1
	if Input.is_key_pressed(KEY_W):
		movement.y = -1
	elif Input.is_key_pressed(KEY_S):
		movement.y = 1
	
	return movement


func get_current_room() -> Node:
	return rooms[current_room_position.y][current_room_position.x]


func switch_to_room(room_position : Vector2) -> bool:
	if not (room_position.x >= 0 and room_position.x <= 1 and room_position.y >= 0 and room_position.y <= 1):
		return false
	
	current_room_position = room_position
	
	var animation = animation_player.get_animation("switch_room")
	animation.track_set_key_value(0, 0, position)
	animation.track_set_key_value(0, 1, get_current_room().position)
	animation_player.play("switch_room")
	
	return true


func _process(delta : float) -> void:
	if !animation_player.is_playing():
		switch_to_room(current_room_position + _get_movement_input())