extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (StateManager.ApartmentState == StateManager.Apartment.NO_PLANTS):
		queue_free()
	add_to_group("Persist")
	$PickupComponent.body_entered.connect(_on_body_entered)
	$PickupComponent.body_exited.connect(_on_body_exited)
	child_entered_tree.connect(player_picks_up)
	pass # Replace with function body.

func player_picks_up(inventory: Node2D):
	if inventory is Inventory:
		StateManager.ApartmentState = StateManager.Apartment.NO_PLANTS

func _on_body_entered(body : Node2D):
	if body.is_in_group("Player"):
		$PickupComponent.player = body
		$PickupComponent.pickup_able = true
		$AnimatedSprite2D.play("QButton")

func _on_body_exited(body : Node2D):
	if body.is_in_group("Player"):
		$PickupComponent.player = null
		$PickupComponent.pickup_able = false
		$AnimatedSprite2D.play("NOTHING")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_pickup_component():
	return $PickupComponent

func get_sprite():
	return $PlantedFlower.texture

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x, # Vector2 is not supported by JSON
		"pos_y" : position.y
	}
	return save_dict
