extends CharacterBody2D

@onready var anim_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	#Change chaque sequence de seed a chaque iteration
	randomize()

	# On lance l'animation
	anim_player.play("cloud")

	# On saute a un temps aleatoire dans l'anim
	var anim := anim_player.get_animation("cloud")
	if anim:
		var len := anim.length
		var t := randf_range(0.0, len)
		anim_player.seek(t, true)
