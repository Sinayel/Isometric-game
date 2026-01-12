class_name level

extends Node2D

func spawn_portal(scene_path: String, pos: Vector2) -> void:
	var portal_scene := preload("res://scenes/teleport_to.tscn") # <-- ta scène portail
	var portal := portal_scene.instantiate() as Portal
	portal.target_scene = scene_path
	portal.position = pos
	print("scene created !")
	add_child(portal)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_down"):
		spawn_portal("res://scenes/house.tscn", Vector2(300, 200))
