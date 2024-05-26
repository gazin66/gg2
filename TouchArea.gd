extends CharacterBody2D
const SPEED = 200.0
const FLY_SPEED = 200.0
const JUMP_VELOCITY = -800.00
const FLY_GRAVITY = 50.0
@onready var bullet_object = preload("res://objects/player/byr.tscn")
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = get_node("AnimatedSprite2D")
var movement_direction = 0
func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y += gravity * delta
	if Input.is_action_just_pressed("shoot"):
		var new_bullet = bullet_object.instantiate()
		new_bullet.position = position
		new_bullet.look_at(get_global_mouse_position()) 
		var cursor_position = get_global_mouse_position()
		var direction_to_cursor = (cursor_position - position).normalized()
		new_bullet.look_at(position + direction_to_cursor)
		get_parent().add_child(new_bullet)
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("jump")

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			anim.play("stop")

	$AnimatedSprite2D.flip_h = direction == -1

	if Input.is_action_pressed("ui_up"):
		velocity.y = -FLY_SPEED
		anim.play("jump")
	if velocity.y > 0:
		anim.play("fall")
	elif velocity.y < 0:
		velocity.y += FLY_GRAVITY * delta

	move_and_slide()



func _on_area_2d_body_entered(body):
	if body.is_in_groop("walls"):
		print("hello")
