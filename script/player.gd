extends CharacterBody2D

@export var walk_speed: float = 45.0
@export var sprint_speed: float = 65.0
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

# Garde la DERNIERE direction de deplacement (sans _idle)
var name_dir: StringName = "down"

func _physics_process(_delta: float) -> void:
	var dir := Input.get_vector("left", "right", "up", "down")
	var current_speed : float
	
	if Input.is_action_pressed("sprint"):
		current_speed = sprint_speed
	else:
		current_speed = walk_speed
	
	velocity = dir * current_speed
	move_and_slide()
	
	# Animation d'arret
	if dir == Vector2.ZERO:
		var idle_name := name_dir + '_idle'
		if anim.sprite_frames and anim.sprite_frames.has_animation(idle_name):
			if !anim.is_playing() or anim.animation != idle_name:
				anim.play(idle_name)
		else:
			if anim.is_playing():
				anim.stop()
		return
	
	var dir_ang := _dir_to_anim(dir)
	name_dir = dir_ang
	
	if anim.animation != dir_ang or !anim.is_playing():
		anim.play(dir_ang)

func _dir_to_anim(dir: Vector2) -> StringName:
	var v := Vector2(dir.x, -dir.y)
	var ang := v.angle()
	var sector := int(round(ang / (PI / 4))) % 8
	
	if sector < 0:
		sector += 8
	print(int(round(ang / (PI / 4))) % 8)
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
