extends KinematicBody2D

"""
The player character used inside stations

Can be moved around with arrow keys.
"""

var motion : Vector2 = Vector2(0, 0)
const SPEED : int = 220
const GRAVITY : int = 30
const JUMP_POWER : int = 700


func _process(delta : float) -> void:
	if Input.is_key_pressed(KEY_A):
		motion.x = -SPEED
	elif Input.is_key_pressed(KEY_D):
		motion.x = SPEED
	
	if test_move(transform, Vector2(0, 1), true):
		if Input.is_key_pressed(KEY_W):
			motion.y = -JUMP_POWER
		else:
			motion.y = 0
	else:
		if not Input.is_key_pressed(KEY_W) and motion.y < 0:
			motion.y /= 1.5
		motion.y += GRAVITY
	
	if move_and_slide(motion, Vector2(0, 1)).y == 0:
		motion.y = 0
	
	motion.x = 0