extends MeshInstance
class_name Station

"""
A station with a 2d level and a 3d mesh

Holds objects, cameras and the player. Handles movement and rotation.
"""


const MOVEMENT_SPEED : float = .1
const ROTATION_SPEED : float = .02

onready var cameras : Spatial = $Cameras


func _ready() -> void:
	update_camera_sockets()


func update_camera_sockets() -> void:
	for camera in cameras.get_children():
		camera.get_node("Socket").transform = transform


func do_rotation(rot : Vector3) -> void:
	rot = -(rot * ROTATION_SPEED)
	
	rotate_object_local(Vector3(1, 0, 0), rot.z)
	rotate_object_local(Vector3(0, 1, 0), rot.x)
	rotate_object_local(Vector3(0, 0, 1), rot.y)
	
	update_camera_sockets()


func do_move(move : Vector3) -> void:
	move = Transform(transform.basis, Vector3(0, 0, 0)).xform(move)
	translation += move * MOVEMENT_SPEED
	
	update_camera_sockets()
