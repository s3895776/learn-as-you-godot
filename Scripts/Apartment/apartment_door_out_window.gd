extends DoorTeleport


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PositionManager.apartment_door_out_window = global_position
	connect_signals()
	pass # Replace with function body.


func teleport_player():
	if can_move:
		Events.load_level.emit(StateManager.Level.LEVEL_ONE)
		Events.move_player.emit(PositionManager.apartment_door_in_window)
#	player position = 
