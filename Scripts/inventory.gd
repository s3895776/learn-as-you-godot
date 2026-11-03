## Inventory (component) stores and displays one item. 
class_name Inventory
extends Node2D
var item: Node2D
var item_sprite: Texture2D
var empty_sprite : Texture2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#	hide first, show next.
	child_exiting_tree.connect(hide_inventory_item)
#	when node enters tree. 
	child_entered_tree.connect(show_inventory_item)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#func signal_inventory_update():
	#inventory_update.emit()

## signal to drop the current item. 
func drop_item():
	Events.dropping.emit()

## show the item in UI
func show_inventory_item(child : Node2D): 
#	if child has pickupItem component: call child "show inventory item"
	#PickupItem
	if child.is_in_group("Item"):
#		get the texture from parent 
		item_sprite = child.get_pickup_component().get_sprite()
		Events.draw_ui.emit(item_sprite)

func hide_inventory_item(child : Node2D):
	Events.draw_ui.emit(empty_sprite)

func get_inventory():
	return self	

## has child
func has_item():
	return self.get_child_count() > 0
