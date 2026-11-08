extends DoorTeleport


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PositionManager.lab_door_in = global_position
	super._ready()
	pass # Replace with function body.

	
func teleport_player():
	if can_move:
		Events.load_level.emit(StateManager.Level.Lab)
		Events.move_player.emit(PositionManager.lab_door_out)
#	player position = 
	
