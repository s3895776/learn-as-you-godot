extends Node2D

@export var level_one_maps_objects : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.entering_level.connect(change_levels)


func change_levels(next_level : StateManager.Level):
	print("At B, go to B.A")
	Saves.save_state($LevelMapsObjects.level_state, $LevelMapsObjects.get_objects())
	print("B.A complete, go to C")
	
	print("At C, go to D")
	
	remove_child($LevelMapsObjects)
	var instance = level_one_maps_objects.instantiate()
	add_child(instance)
	print("At D, now go to D.A")
	Saves.load_state(next_level)
#	saves will reload some objects which need to return to normal.

	$LevelMapsObjects.switch_objects()
