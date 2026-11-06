extends TimeSwitchObject
@export var seed_sprite: Sprite2D
@export var vine_platform: StaticBody2D
@export var pickup_component: PickupItemComponent

#if the seed is planted, tree can be placed in the scene.
#if not planted, the future will not show this seed. 
 
var planted = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func vine_visibility_collision_enabled(enabled : bool):
	vine_platform.visible = enabled	
	set_collision(vine_platform, enabled)
		

func set_collision(collision_obj: CollisionObject2D, enabled : bool):
	if (enabled):
		collision_obj.process_mode = Node.PROCESS_MODE_ALWAYS   
	else:
		collision_obj.process_mode = Node.PROCESS_MODE_DISABLED 
	

func switch_object(future: bool):
	if future:
		vine_visibility_collision_enabled(true)
		$Seed.visible = false
		set_collision(pickup_component, false)
		
	else:
		$Seed.visible = true
		set_collision(pickup_component, true)
		vine_visibility_collision_enabled(false)
		
func _on_pickup_component_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$Buttons.play("QButton")

func _on_pickup_component_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$Buttons.play("NOTHING")

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x, # Vector2 is not supported by JSON
		"pos_y" : position.y
	}
	return save_dict

## gets the sprite of the tree
func get_sprite():
	return seed_sprite.texture

## get pickupcomponent variable
func get_pickup_component():
	return pickup_component
