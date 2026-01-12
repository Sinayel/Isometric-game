extends Node2D

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_down"):
		print("wtf")
		Level.spawn_portal("res://scenes/level.tscn", Vector2(0, 0))
