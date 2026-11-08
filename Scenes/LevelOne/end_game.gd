extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PositionManager.end_game = global_position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("THANKS FOR PLAYING")
		Events.load_level.emit(StateManager.Level.FIN)
		Events.move_player.emit(Vector2(0,0))
	pass # Replace with function body.
