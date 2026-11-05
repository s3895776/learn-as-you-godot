## attach to a level to determine what to save. 
@abstract class_name SaveLevelComponent extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.add_to_group("Saves")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

@abstract func save_level()
