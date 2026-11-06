extends Node2D
# 

#these should be pointers
var present_map : Node2D
var future_map : Node2D

var is_future = false

var apartment_state = StateManager.Apartment.PLANTS
@export var apartment_area : Area2D

# array for grabbed objects: can be a separate class type. 
var grabbed_objects: Array[Node2D]
var player_grabbing = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	present_map = $CurrentPresentLevel
	future_map = $CurrentFutureLevel
	
#	signal player switching time
	Events.time_switch.connect(switch_maps)
	Events.dropped_on.connect(reparent_dropped_item)
	Events.levels_loaded.connect(change_levels)
#	set visibility and collision (runs switch object after)
	switch_maps()

## go from first level to any level
func change_levels(present : PackedScene, future : PackedScene):
	print("change levels!")
	#present_map = present
	#future_map = future
	remove_child(present_map)
	remove_child(future_map)
	var instance = present.instantiate()
	add_child(instance)
	instance = future.instantiate()
	add_child(instance)
	#present_map = present
	#future_map = future
	#present_map.change_to_packed_scene(present)
	#future_map.change_to_packed_scene(future)
	switch_maps()
	
## change the time of the leveL: swap present and future map
func switch_maps():
	#print("switching time")
	is_future = not is_future
	if (is_future):
#		careful with the collision as the player may clip into or fall based on the order of ops.
		_enable_map(future_map, true)
		_enable_map(present_map, false)
	else:
		_enable_map(present_map, true)
		_enable_map(future_map, false)
	set_state_apartment()
	switch_objects()
	
## checks all children, not recursive, for the base time switch objects. 
## scenes need switchable objects to exist only as children on map node
func switch_objects():
#	signal: request switch
	for c in $Objects.get_children():
		if c is TimeSwitchObject:
			c.switch_object(is_future)
		
## call this on switch maps to set state apartment to the correct thing.
func set_state_apartment():
	for child in apartment_area.get_children():
		if "state_enabled" in child:
			child.state_enabled = false
	if is_future and apartment_state == StateManager.Apartment.PLANTS:
		$Apartment_Area/apt_future.state_enabled = true
	elif is_future and apartment_state == StateManager.Apartment.NO_PLANTS:
		$Apartment_Area/apt_future_2.state_enabled = true
	elif not is_future and apartment_state == StateManager.Apartment.PLANTS:
		$Apartment_Area/apt_past.state_enabled = true
	elif is_future and apartment_state == StateManager.Apartment.PLANTS:
		$Apartment_Area/apt_past_2.state_enabled = true
		
	for child in apartment_area.get_children():
		if child.has_method("set_enabled"):
			child.set_enabled()
		
func _enable_map(map : BaseLevel, enable : bool):
#	set visibility of the node in addition to collisions of the tilemap.
	map.visible = enable
	map.enable_map(enable)
	
func reparent_dropped_item(child: Node2D):
	child.reparent(self)
