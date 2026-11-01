class_name PickupItem
extends Area2D

#signal pickup
#ask parent to give sprite2D location
signal show_sprite

var pickup_able = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# add parent to the group
	get_parent().add_to_group("Item")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func is_pickup_able():
	if (self.visible == false):
		return false
	return pickup_able
## call this function upon player interact. 


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		pickup_able = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		pickup_able = false

func get_sprite():
	return get_parent().get_sprite()
