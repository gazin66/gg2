extends Node2D

var tilemap
var tile_position

func _ready():
	tilemap = get_parent().get_node() # Убедитесь, что имя TileMap соответствует имени в вашей сцене

func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		var camera = get_viewport().get_camera_2d()
		if camera:
			var ray_origin = camera.project_ray_origin(event.position)
			var ray_direction = camera.project_ray_normal(event.position)
			var space_state = get_world_2d().direct_space_state
			var result = space_state.intersect_ray(ray_origin, ray_direction, [self], 0x7fffffff)
			if result:
				tile_position = tilemap.world_to_map(result.position)
				animate_tile(tile_position)

func animate_tile(position):
	var tile_data = tilemap.get_tile_data(position)
	if tile_data:
		var new_tile_id = 1 # Укажите ID плитки, которую вы хотите показать при касании
		tilemap.set_cell(position.x, position.y, new_tile_id)
	
