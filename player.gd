extends CharacterBody2D

@export var speed := 45.0
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

# Garde la DERNIERE direction de deplacement (sans _idle)
var last_anim := "down"

func _physics_process(_delta: float) -> void:
	var dir := Input.get_vector("left", "right", "up", "down")

	# Deplacement
	velocity = dir * speed
	move_and_slide()

	# --- ANIMATIONS ---
	if dir == Vector2.ZERO:
		# A l'arretes jouer l'anim idle de la derniere direction
		var idle_name := last_anim + "_idle"

		if anim.sprite_frames and anim.sprite_frames.has_animation(idle_name):
			if !anim.is_playing() or anim.animation != idle_name:
				anim.play(idle_name)
		else:
			if anim.is_playing():
				anim.stop()
		return

	# animation de marche/course
	var a := _dir_to_anim(dir)
	last_anim = a
	
	if anim.animation != a or !anim.is_playing():
		anim.play(a)

func _dir_to_anim(dir: Vector2) -> StringName:
	var v := Vector2(dir.x, -dir.y)
	var ang := v.angle()
	var sector := int(round(ang / (PI / 4))) % 8

	if sector < 0:
		sector += 8

	match sector:
		0: return "right"
		1: return "downRight"
		2: return "down"
		3: return "downLeft"
		4: return "left"
		5: return "upLeft"
		6: return "up"
		7: return "upRight"

	return "down"
