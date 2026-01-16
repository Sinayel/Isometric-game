class_name Level

extends Node2D

@onready var AllStickNode: Array = $AllStick.get_children()
var size: int = 0

func spawn_portal(scene_path: String, pos: Vector2) -> void:
	var portal_scene := preload("res://scenes/teleport_to.tscn")
	var portal := portal_scene.instantiate() as Portal
	portal.teleport_to = scene_path
	print("portal spawner")
	portal.position = pos
	print("scene created !")
	add_child(portal)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_down"):
		spawn_portal("res://scenes/house.tscn", Vector2(-110, -42))

func _process(_delta: float) -> void:
	if $AllStick:
		AllStickNode = $AllStick.get_children()
	if AllStickNode.size() == 0:
		print("Some Text")
