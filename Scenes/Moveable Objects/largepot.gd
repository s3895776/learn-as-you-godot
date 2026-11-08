class_name LargePot extends TimeSwitchObject

@onready var pastObject = $OriginPoint/PastObject
@onready var futureObject = $OriginPoint/FutureObject
@onready var moveComponent = $OriginPoint/MoveComponent
@onready var pastCollider = $OriginPoint/CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

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

	return 
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
