extends Node

var game_over : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if game_over:
		print("Go to Menu")
	else:
		print("Keep playing")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print("Time")
