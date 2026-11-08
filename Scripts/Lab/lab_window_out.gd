extends DoorTeleport

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PositionManager.lab_window_out = global_position
	super._ready()
	pass # Replace with function body.

	
func teleport_player():
	pass
#	player position = 

func _on_body_entered(body: Node2D) -> void:
	pass

func _on_body_exited(body: Node2D) -> void:
	pass
