extends CharacterBody2D

func take_damage(i: int):
	if i == 0:
		queue_free()
