extends Node2D
var level_state = StateManager.Level.Apartment

#these should be references, not instantiated. 
var present_map : BaseLevel
var future_map : BaseLevel

# for any objects present in scene.
var current_objects: Node2D

func get_objects():
	return current_objects

func set_objects(objects: Node2D):
	current_objects = objects

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_state_apartment()
	set_objects($Objects)
	
#	signal player switching time
	Events.time_switch.connect(swap_is_future)
	Events.dropped_on.connect(reparent_dropped_item)
	

func swap_is_future():
	StateManager.is_future = not StateManager.is_future
	switch_maps()

## change the time of the leveL: swap present and future map
func switch_maps():
	print("switching maps in apartment maps")
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
			print(c)
			c.switch_object(StateManager.is_future)
		
## call this when switching the state of the apartment (with plants)
## and _ready().
## will correctly allocate future map and present map.
func set_state_apartment():
	_enable_map($apt_past, false)
	_enable_map($apt_future, false)
	_enable_map($apt_past_2, false)
	_enable_map($apt_future_2, false)
	
	if StateManager.ApartmentState == StateManager.Apartment.NO_PLANTS:
#		TODO: method to complete the different states. 
		future_map = $apt_future_2
		present_map = $apt_past_2
	else:
		future_map = $apt_future
		present_map = $apt_past
	
#	reload visibility
	switch_maps()
	
		
func _enable_map(map : BaseLevel, enable : bool):
#	set visibility of the node in addition to collisions of the tilemap.
	map.visible = enable
	map.enable_map(enable)
	
func reparent_dropped_item(child: Node2D):
	child.reparent($Objects)

## get the root of any node that has "Persist"
## alternatively, can call propagate. 
func save_level():
	Saves.save_state(level_state, get_objects())
	
