extends TimeSwitchObject
@export var area_2d: Area2D
var pickup = false


#if the seed is planted, tree can be placed in the scene.
#if not planted, the future will not show this seed. 
 
var planted = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_pickup()
	pass

func _pickup():
	if pickup == true:
		print ("SEED")

func map_visibility_collision_enabled(map : TileMapLayer, change : bool):
	map.visible = change
	map.set_enabled(change)
	
func switch_object(future: bool):
	if future:
		map_visibility_collision_enabled($Tree, true)
		$Seed.visible = false
	else:
		$Seed.visible = true
		map_visibility_collision_enabled($Tree, false)
		

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		pickup = true
		$Buttons.play("QButton")


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		pickup = false
		$Buttons.play("NOTHING")
