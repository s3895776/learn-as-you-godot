## handles any logic have a node be picked up. Needs parent to implement functionality.
class_name PickupItemComponent
extends Area2D


var player : Node2D
var pickup_able = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# add parent to the group
	get_parent().add_to_group("Item")
	
	Events.grabbing.connect(_on_inventory_is_grabbing)
	Events.dropping.connect(on_inventory_drop_item)
	
	pass # Replace with function body.

func is_pickup_able():
	if (self.visible == false):
		return false
	return pickup_able
## call this function upon player interact. 


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = body
		pickup_able = true
		
func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = null
		pickup_able = false

#func drop_item(parent_node : Node):
	#Events.dropping.emit(get_parent())
	
func on_inventory_drop_item():
	if is_pickup_able():
		Events.dropped_on.emit(get_parent())
	
func _on_inventory_is_grabbing():
	if is_pickup_able():
		get_parent().reparent(player.get_player_inventory())
	
func get_sprite():
	return get_parent().get_sprite()
