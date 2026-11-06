extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.entering_level.connect(change_levels)


func change_levels():
	print("I'm B, go to B.A")
	Saves.save_state(StateManager.Level.LEVEL_ONE, $Objects)
	
	print("I'm C, go to D")
	
	print("At D, now go to D.A")
