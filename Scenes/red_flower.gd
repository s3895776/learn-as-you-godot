extends Node2D

var pickup_able : bool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (StateManager.player_picked_up_seed):
		queue_free()
	add_to_group("Persist")
	$Collision.body_entered.connect(_on_body_entered)
	$Collision.body_exited.connect(_on_body_exited)
	Events.grabbing.connect(player_picks_up)
	pass # Replace with function body.

func player_picks_up():
	if pickup_able:
		StateManager.ApartmentState = StateManager.Apartment.NO_PLANTS
		StateManager.player_picked_up_seed = true
		queue_free()

func _on_body_entered(body : Node2D):
	if body.is_in_group("Player"):
		pickup_able = true
		$AnimatedSprite2D.play("QButton")

func _on_body_exited(body : Node2D):
	if body.is_in_group("Player"):
		pickup_able = false
		$AnimatedSprite2D.play("NOTHING")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x, # Vector2 is not supported by JSON
		"pos_y" : position.y
	}
	return save_dict
