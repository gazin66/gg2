extends CharacterBody2D
const SPEED = 200.0
const FLY_SPEED = 200.0
const JUMP_VELOCITY = -800.00
const FLY_GRAVITY = 50.0
@onready var bullet_object = preload("res://objects/player/byr.tscn")
@onready var bullet_object1 = preload("res://objects/player/giga_byr.tscn")
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
var new_bullet1
var drill_pressed = false
var existing_bullet = null
var movement_direction1
func _ready():
	movement_direction1 = ((get_global_mouse_position())- position).normalized()
# Функция, которая вызывается каждый кадр
func _process(delta):
	# Проверяем, нажата ли клавиша или действие "drill"
	if Input.is_action_pressed("drill"):
		# Если действие "drill" нажато и снаряда еще нет или он уже удален
		if existing_bullet == null:
			# Создаем новый снаряд
			var new_bullet1 = bullet_object1.instantiate()
			new_bullet1.position = position
			new_bullet1.look_at(get_global_mouse_position())
			get_parent().add_child(new_bullet1)
			# Сохраняем ссылку на созданный снаряд
			existing_bullet = new_bullet1

		# Если действие "drill" нажато и снаряд уже создан
		if existing_bullet:
			# Получаем позицию курсора мыши
			
			# Вычисляем направление от персонажа к курсору
			var direction_to_cursor = (movement_direction1 - position).normalized()
			

	# Если действие "drill" отпущено, удаляем снаряд
	if !Input.is_action_pressed("drill"):
		if existing_bullet:
			existing_bullet.queue_free()
			existing_bullet = null
	if existing_bullet:
		
		existing_bullet.position = position
	if existing_bullet:
		var cursor_position = get_global_mouse_position()
		var direction_to_cursor = (cursor_position - position)
		existing_bullet.look_at(position + direction_to_cursor)
	move_and_slide()

var timer

func _init():
	timer = Timer.new()
	add_child(timer)
	timer.autostart = true
	timer.wait_time = 0.5
	timer.connect("timeout", self, "_timeout")


func _timeout():
	print("Timed out!")

