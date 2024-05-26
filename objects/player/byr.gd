extends CharacterBody2D
var target_position = Vector2(0, 0)
var movement_direction = Vector2(0, 0) 
const SPEED = 100.0
var cursor_position 
var direction 
var collision_info 
func _ready():
	movement_direction = ((get_global_mouse_position())- position).normalized()

func _physics_process(delta):
	direction = (target_position - position).normalized()
	velocity = movement_direction  * SPEED 
	collision_info = move_and_collide(velocity*delta)
	collision()
	


func collision():
	if collision_info == null: return
	var collider = collision_info.get_collider()
	if collider is TileMap:
		var collision_position = collision_info.get_position() + movement_direction
		var cell_x = round(collision_position.x)
		var cell_y = round(collision_position.y) 
		collision_position = Vector2(cell_x,cell_y)
		var local_position = collider.to_local(collision_position)
		var offset = Vector2(0, 0)  # 1 пиксель по обеим осям
		var adjusted_local_position = (local_position + offset) 
		var map_position = collider.local_to_map(adjusted_local_position)
		collider.erase_cell(0, map_position)
		queue_free()


