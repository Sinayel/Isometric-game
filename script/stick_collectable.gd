extends StaticBody2D

@export var item: InvItem

func _ready() -> void:
	$InteractArea.body_entered.connect(_on_interact_area_body_entered)

# Des qu'un objets/personnage rentre dans la zone de collision
func _on_interact_area_body_entered(body: Node2D) -> void:
	if body.has_method("collect"):
		body.collect(item)
		await get_tree().create_timer(0.3).timeout
		queue_free()
