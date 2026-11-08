extends DoorTeleport

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PositionManager.lab_window_in = global_position
	super._ready()
	pass # Replace with function body.

	
func teleport_player():
	if can_move:
		Events.load_level.emit(StateManager.Level.Lab)
		Events.move_player.emit(PositionManager.lab_window_out)
#	player position = 

# automatically move the player
func _on_body_entered(body: Node2D) -> void:
	super._on_body_entered(body)
	if (body.is_in_group("Player")):
		teleport_player()
