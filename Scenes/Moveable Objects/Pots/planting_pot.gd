extends LargePot

var is_planted : bool = false
var can_plant = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	plant_seed(StateManager.is_future)
	Events.grabbing.connect(player_plants_seed)
	pass # Replace with function body.

func player_plants_seed():
	#if StateManager.player_picked_up_seed and player is next to thing
	if can_plant:
		is_planted = true
		$OriginPoint/PastObject/PlantedFlower.visible = is_planted
	

func plant_seed(future):
	if (future): 
		$OriginPoint/FutureObject.visible = is_planted
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


func _on_plant_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_plant = true
	pass # Replace with function body.


func _on_plant_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_plant = false
		 # Replace with function body.
