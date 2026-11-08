extends Node2D
# 

var level_state = StateManager.Level.LEVEL_ONE

#these should be references, not instantiated. 
var present_map : BaseLevel
var future_map : BaseLevel
var current_objects: Node2D


func get_objects():
	return current_objects

func set_objects(objects: Node2D):
	current_objects = objects

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	present_map = $CurrentPresentLevel
	future_map = $CurrentFutureLevel
	set_objects($Objects)
#	signal player switching time
	Events.time_switch.connect(swap_is_future)
	Events.dropped_on.connect(reparent_dropped_item)
	
#	set visibility and collision (runs switch object after)
	switch_maps()

func swap_is_future():
	StateManager.is_future = not StateManager.is_future
	switch_maps()

## change the time of the leveL: swap present and future map
func switch_maps():
	#print("switching time")
	if (StateManager.is_future):
#		careful with the collision as the player may clip into or fall based on the order of ops.
		_enable_map(future_map, true)
		_enable_map(present_map, false)
	else:
		_enable_map(present_map, true)
		_enable_map(future_map, false)
	switch_objects()
	
## checks all children, not recursive, for the base time switch objects. 
## scenes need switchable objects to exist only as children on map node
func switch_objects():
#	signal: request switch
	for c in $Objects.get_children():
		if c is TimeSwitchObject:
			c.switch_object(StateManager.is_future)
	
func _enable_map(map : BaseLevel, enable : bool):
#	set visibility of the node in addition to collisions of the tilemap.
	map.visible = enable
	map.enable_map(enable)
	
func reparent_dropped_item(child: Node2D):
	child.reparent($Objects)

func save_level():
	Saves.save_state(level_state, get_objects())
	Saves.save_state(level_state, $CurrentFutureLevel)
	return
