extends KinematicBody2D

"""
The player character used inside stations

Can be moved around with arrow keys.
"""

onready var main : Node2D = $"/root/Main"

var motion : Vector2 = Vector2(0, 0)
const SPEED : int = 220
const GRAVITY : int = 30
const JUMP_POWER : int = 700
const LADDER_SPEED : int = 300


func _process(delta : float) -> void:
	if Input.is_key_pressed(KEY_A):
		motion.x = -SPEED
	elif Input.is_key_pressed(KEY_D):
		motion.x = SPEED
	
	var current_station : Station = main.current_station
	var tilemap : TileMap = current_station.get_node("Level/TileMap")
	
	if tilemap.get_cellv((position - tilemap.global_position) / 70) == 1:
		motion.y = 0
		if Input.is_key_pressed(KEY_W):
			motion.y = -LADDER_SPEED
		elif Input.is_key_pressed(KEY_S):
			motion.y = LADDER_SPEED
	elif test_move(transform, Vector2(0, 1), true):
		motion.y = 0
		if Input.is_key_pressed(KEY_W):
			motion.y = -JUMP_POWER
	else:
		if not Input.is_key_pressed(KEY_W) and motion.y < 0:
			motion.y /= 1.5
		motion.y += GRAVITY
	
	if move_and_slide(motion, Vector2(0, 1)).y == 0:
		motion.y = 0
	
	motion.x = 0