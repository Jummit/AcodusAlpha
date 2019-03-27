extends "res://Objects/Object/Object.gd"

"""
Used for moving to the ship that is docked by right clicking.
"""

onready var player : KinematicBody2D = $"/root/Main/Player"


func _on_clicked() -> void:
	var docking_ship : Station = station.get_ships_in_range()[0]
	if docking_ship:
		player.position = docking_ship.entry.global_position
		
		docking_ship.level.show()
		docking_ship.hide()
		
		station.level.hide()
		station.show()
