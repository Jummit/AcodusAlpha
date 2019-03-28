extends "res://Objects/Object/Object.gd"

"""
Used for moving to the ship that is docked by right clicking.
"""

onready var main : Node2D = $"/root/Main"
onready var player : KinematicBody2D = $"/root/Main/Player"
onready var tint_layer : CanvasLayer = $"/root/Main/TintLayer"

func _on_clicked() -> void:
	var docking_ship : Station = station.get_ships_in_range()[0]
	if docking_ship:
		var tint_animation_player : AnimationPlayer = tint_layer.get_node("AnimationPlayer")
		tint_animation_player.play("FadeIn")
		
		player.position = docking_ship.entry.global_position
		
		docking_ship.level.show()
		docking_ship.hide()
		
		station.level.hide()
		station.show()
		
		main.current_station = docking_ship
		
		tint_animation_player.play_backwards("FadeIn")
