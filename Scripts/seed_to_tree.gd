extends TimeSwitchObject
@export var pickup_component: PickupItem
@export var seed: Sprite2D

#if the seed is planted, tree can be placed in the scene.
#if not planted, the future will not show this seed. 
 
var planted = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func map_visibility_collision_enabled(map : TileMapLayer, change : bool):
	map.visible = change
	map.set_enabled(change)
	
func switch_object(future: bool):
	if future:
		map_visibility_collision_enabled($Tree, true)
		$Seed.visible = false
		$PickupComponent.visible = false
		
	else:
		$PickupComponent.visible = true
		$Seed.visible = true
		map_visibility_collision_enabled($Tree, false)
		
func _on_pickup_component_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$Buttons.play("QButton")


func _on_pickup_component_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$Buttons.play("NOTHING")

## player will grab the seed 
func _on_player_grabbing(Player : CharacterBody2D) -> void:
	if pickup_component.is_pickup_able() == true:
## increased scope responsibility, alternative is to make this class extend pickup class. 
		self.reparent(Player.inventory)
	pass # Replace with function body.

## show the sprite (seed) 
func _on_pickup_component_show_sprite() -> void:
	pass # Replace with function body.

## gets the sprite of the tree
## another function which relates to pickup component
func get_sprite():
	return seed.texture

## another function exclusively pickupcomponent
func get_pickup_component():
	return pickup_component
