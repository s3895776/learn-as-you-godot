extends LargePot

var is_planted : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	plant_seed(StateManager.is_future)
	Events.planting_pot.connect(plant_seed)
	pass # Replace with function body.

func plant_seed(future):
	if (future): 
		$OriginPoint/FutureObject/BigVines.visible = is_planted
	else:
		$OriginPoint/PastObject/PlantedFlower.visible = is_planted
	
func switch_object(future):
	if future:
		pastCollider.disabled = true
		for child in moveComponent.get_children():
			if child is RayCast2D:
				child.enabled = false
		for child in pastObject.get_children():
			if child is Sprite2D:
				child.visible = false 
		for child in futureObject.get_children():
			if child is Sprite2D:
				child.visible = true 	
			if child is CollisionShape2D:
				child.disabled = false
			if child is AnimatedSprite2D:
				child.visible = true
	else:
		pastCollider.disabled = false
		for child in moveComponent.get_children():
			if child is RayCast2D:
				child.enabled = true
		for child in pastObject.get_children():
			if child is Sprite2D:
				child.visible = true 
		for child in futureObject.get_children():
			if child is Sprite2D:
				child.visible = false 	
			if child is CollisionShape2D:
				child.disabled = true
			if child is AnimatedSprite2D:
				child.visible = false
	plant_seed(future)
	return 
