extends Node2D

@export var level_one_maps_objects : PackedScene
@export var apartment : PackedScene
@export var lab : PackedScene
@export var sewer : PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#	TODO: ensure signal matches load_level
	Events.load_level.connect(change_levels)

#change to current_level + next_level
func change_levels(next_level : StateManager.Level):
	print("At B")
	var level_node : Node2D
	for child in get_children():
		if child.has_method("save_level"):
			level_node = child
	if (level_node != null):
		level_node.save_level()
		print("Save success")
	
	remove_child(level_node)
	
#	calling queue free removes signals. 
	level_node.queue_free()
	var instance : Node2D
	if (next_level == StateManager.Level.LEVEL_ONE):
		instance = level_one_maps_objects.instantiate()
		StateManager.current_level = StateManager.Level.LEVEL_ONE
	elif next_level == StateManager.Level.Apartment:
		instance = apartment.instantiate()
		StateManager.current_level = StateManager.Level.Apartment
	elif next_level == StateManager.Level.Lab:
		instance = lab.instantiate()
		StateManager.current_level = StateManager.Level.Lab
	elif next_level == StateManager.Level.FIN:
		instance = sewer.instantiate()
	else:
#		only works in editor.
		assert(false, "Level Type incorrectly entered")
		
	print("AT C")
	add_child(instance)
	print("At D")
	Saves.load_state(next_level)
	print("Load finished")
	for child in get_children():
		if child.has_method("switch_objects"):
			level_node = child
#	saves will reload some objects which need to return to normal
	level_node.switch_maps()
