extends Node2D
class_name ShowText

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player and global_position == Vector2(58.0, -165.0):
		body.set_hint_visible(true, 1)   # 👈 affiche le texte

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		body.set_hint_visible(false, 0)  # 👈 cache le texte

# (58.0, -165.0)
