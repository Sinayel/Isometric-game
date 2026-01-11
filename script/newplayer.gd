extends CharacterBody2D

@export var inv: Inv


@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var attack_area: Area2D = $AttackPivot/AttackArea
@onready var attack_pivot: Node2D = $AttackPivot

const speed := 60.0
const sprint_speed := 80.0
var is_attacking := false
var last_dir: Vector2 = Vector2.RIGHT

func _ready() -> void:
	anim.animation_finished.connect(_on_anim_finished)
	attack_area.monitoring = false
	attack_area.connect("body_entered", _on_attack_area_body_entered)

func _physics_process(_delta: float) -> void:
	if is_attacking:
		return
	var current_speed := speed
	
	if Input.is_action_just_pressed("click"):
		is_attacking = true
		anim.play("attack")
		anim_player.play("attack")
		attack_area.monitoring = true
		return
	if Input.is_action_pressed("sprint"):
		current_speed = sprint_speed
	
	var dir := Input.get_vector("left", "right", "up", "down")
	if dir != Vector2.ZERO:
		velocity = current_speed * dir
		move_and_slide()
		
		# Flip du pivot au lieu de flip du sprite
		if dir.x > 0:
			anim.flip_h = false
			attack_pivot.scale.x = 1
		elif dir.x < 0:
			anim.flip_h = true
			attack_pivot.scale.x = -1
		
		
		if !anim.is_playing() or anim.animation != 'walk':
			anim.play('walk')
	else:
		if anim.sprite_frames and anim.sprite_frames.has_animation('walk_idle'):
			if !anim.is_playing() or anim.animation != 'walk_idle':
				anim.play('walk_idle')
		else:
			if anim.is_playing():
				anim.stop()

func _on_anim_finished() -> void:
	if anim.animation == "attack":
		is_attacking = false
		attack_area.monitoring = false

func _on_attack_area_body_entered(body: Node) -> void:
	if is_attacking and body.is_in_group("enemies"):
		print("Touche :", body.name)
		body.take_damage(self)

func collect(item):
	inv.insert(item)

func changed_scene(pathScene: String):
	if pathScene:
		get_tree().change_scene_to_file(pathScene)
