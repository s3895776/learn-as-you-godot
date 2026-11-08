extends DoorTeleport


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PositionManager.apartment_door_in_window = global_position
	super._ready()
	pass # Replace with function body.

func is_apartment_plants():
	if (StateManager.is_future and StateManager.ApartmentState == StateManager.Apartment.PLANTS):
		return true
	return false
	
func teleport_player():
	if can_move and not is_apartment_plants():
		Events.load_level.emit(StateManager.Level.Apartment)
		Events.move_player.emit(PositionManager.apartment_door_out_window)
#	player position = 
