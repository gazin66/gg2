extends CharacterBody2D
var target_position = Vector2(0, 0)
var movement_direction = Vector2(0, 0) 
const SPEED = 50.0
var cursor_position 
var direction 
func _ready():
	movement_direction = ((get_global_mouse_position())- position).normalized()

func _physics_process(delta):
	direction = (target_position - position).normalized()
	move_and_slide()
	velocity = movement_direction  * SPEED 
	var collision_info = move_and_collide(velocity*delta)
	if collision_info:
		var collider = collision_info.get_collider()
		if collider is TileMap:
			var collision_position = collision_info.get_position() + movement_direction
			var local_position = collider.to_local(collision_position)
			var map_position = collider.local_to_map(local_position)

			collider.erase_cell(0, map_position)
			print(map_position)
			print(get_position())
		queue_free()
