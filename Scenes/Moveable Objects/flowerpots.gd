class_name FlowerPot extends TimeSwitchObject

@onready var pastObject = $OriginPoint/PastObject
@onready var futureObject = $OriginPoint/FutureObject


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func switch_object(future):
	if future:
		for child in pastObject.get_children():
			if child is Sprite2D:
				child.visible = false 
		for child in futureObject.get_children():
			if child is Sprite2D:
				child.visible = true 	
			if child is AnimatedSprite2D:
				child.visible = true
	else:
		for child in pastObject.get_children():
			if child is Sprite2D:
				child.visible = true 
		for child in futureObject.get_children():
			if child is Sprite2D:
				child.visible = false 	
			if child is AnimatedSprite2D:
				child.visible = false

	return 
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
