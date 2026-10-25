extends Sprite2D

var speed : float = 10.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(position) 
	#position.x = 400
	#position.y = 500
	position = Vector2(500, 200)
	global_position = Vector2(60,5)
	global_position.x += 50
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = Vector2(1,1)
#	60 FPS: delta = 0.016
	position += direction * speed * delta
