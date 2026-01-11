extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

@export var max_speed: float = 25.0
@export var min_dir_time: float = 1.2
@export var max_dir_time: float = 2.5
@export var smooth_factor: float = 4.0

@export var item: InvItem
var player: CharacterBody2D = null

var current_dir: Vector2 = Vector2.ZERO
var time_left: float = 0.0

func _ready() -> void:
	add_to_group("player")
	player = get_tree().get_first_node_in_group("player")
	randomize()
	_pick_new_direction()

func _physics_process(delta: float) -> void:
	time_left -= delta
	if time_left <= 0.0:
		_pick_new_direction()

	var target_velocity := current_dir * max_speed

	velocity = velocity.lerp(target_velocity, smooth_factor * delta)

	# Déplacement avec collisions
	move_and_slide()

	if velocity.length() < 1.0:
		# Anim idle
		if anim.sprite_frames and anim.sprite_frames.has_animation("walk_idle"):
			if !anim.is_playing() or anim.animation != "walk_idle":
				anim.play("walk_idle")
		else:
			if anim.is_playing():
				anim.stop()
		return

	if velocity.x > 0.0:
		anim.flip_h = false
	elif velocity.x < 0.0:
		anim.flip_h = true

	if !anim.is_playing() or anim.animation != "walk":
		anim.play("walk")

func take_damage(player) -> void:
	player.collect(item)
	queue_free()

func _pick_new_direction() -> void:
	var r := randi_range(0, 2)
	if r == 0:
		current_dir = Vector2.ZERO
	else:
		var dir_index := randi_range(0, 7)
		current_dir = _get_some_vector(dir_index).normalized()

	time_left = randf_range(min_dir_time, max_dir_time)

func _get_some_vector(nb_ale: int) -> Vector2:
	match nb_ale:
		0, 7:
			return Vector2(0, -1)
		2, 3:
			return Vector2(0, 1)
		1, 5:
			return Vector2(1, 0)
		4, 6:
			return Vector2(-1, 0)
	return Vector2(0, 1)
