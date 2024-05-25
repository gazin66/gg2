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
			var bullet_radius = 2
			var collision_position = collision_info.get_position() + ((movement_direction) *bullet_radius)
			var cell_x = round(collision_position.x)
			var cell_y = round(collision_position.y) 
			collision_position = Vector2(cell_x,cell_y)
			var local_position = collider.to_local(collision_position)
			var offset = Vector2(0, 0)  # 1 пиксель по обеим осям
			var adjusted_local_position = (local_position + offset) 
			var map_position = collider.local_to_map(adjusted_local_position)
			 
			
			collider.erase_cell(0, map_position)
			print(map_position)
			print(collision_position)
			print(adjusted_local_position)
			print(movement_direction)
		queue_free()
