class_name Portal

extends Area2D

@export_file("*.tscn") var teleport_to : String

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		get_tree().change_scene_to_file(teleport_to)
