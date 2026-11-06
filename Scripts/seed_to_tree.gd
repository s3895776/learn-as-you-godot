extends TimeSwitchObject
@export var pickup_component: PickupItemComponent
@export var seed_sprite: Sprite2D
@export var tree: TileMapLayer

#if the seed is planted, tree can be placed in the scene.
#if not planted, the future will not show this seed. 
 
var planted = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func map_visibility_collision_enabled(map : TileMapLayer, change : bool):
	map.visible = change
	map.set_enabled(change)
	
func switch_object(future: bool):
	if future:
		map_visibility_collision_enabled(tree, true)
		$Seed.visible = false
		$PickupComponent.visible = false
		
	else:
		$PickupComponent.visible = true
		$Seed.visible = true
		map_visibility_collision_enabled(tree, false)
		
func _on_pickup_component_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$Buttons.play("QButton")

func _on_pickup_component_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$Buttons.play("NOTHING")


## gets the sprite of the tree
func get_sprite():
	return seed_sprite.texture

## get pickupcomponent variable
func get_pickup_component():
	return pickup_component
