extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func _on_body_entered(body: PhysicsBody2D):
	if body.is_in_group("enemy"):
		# Код, выполняемый при столкновении с врагом
		pass
		
