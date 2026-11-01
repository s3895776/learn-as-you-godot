class_name Inventory
extends Node2D
var item: Node2D
var item_sprite: Texture

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

## show 

## show the item in UI
func show_inventory_item(): 
#	if child has pickupItem component: call child "show inventory item"
	#PickupItem
	var child = self.get_child(0)
	if child.is_in_group("Item"):
#		get the texture from parent 
		item_sprite = child.get_pickup_component().get_sprite()
#		TODO: draw the item_sprite onto UI.

func get_inventory():
	return self	

## has child
func has_item():
	return self.get_child_count() > 0
