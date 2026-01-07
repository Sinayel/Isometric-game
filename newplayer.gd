extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
const speed := 60.0

var is_attacking := false

func _ready() -> void:
	anim.animation_finished.connect(_on_anim_finished)

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("click") and !is_attacking:
		is_attacking = true
		anim.play("attack")
		return

	if is_attacking:
		return

	var dir := Input.get_vector("left", "right", "up", "down")
	velocity = speed * dir
	move_and_slide()
	if dir == Vector2.ZERO:
		if anim.sprite_frames and anim.sprite_frames.has_animation('walk_idle'):
			if !anim.is_playing() or anim.animation != 'walk_idle':
				anim.play('walk_idle')
		else:
			if anim.is_playing():
				anim.stop()
		return
		
	if dir.x > 0:
		anim.flip_h = false
	elif dir.x < 0:
		anim.flip_h = true
	
	if !anim.is_playing() or anim.animation != 'walk':
		anim.play('walk')

func _on_anim_finished() -> void:
	if anim.animation == "attack":
		is_attacking = false
