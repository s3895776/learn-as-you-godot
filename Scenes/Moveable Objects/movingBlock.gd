extends TimeSwitchObject

@onready var pastObject = $PastObject
@onready var futureObject = $FutureObject
@onready var pastCollider = $PastObject/CollisionShape2D
@onready var moveComponent = $PastObject/MoveComponent


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

	return 
func _physics_process(delta: float) -> void:
	
	return 
