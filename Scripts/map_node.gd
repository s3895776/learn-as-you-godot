extends Node2D
# 

var switchable_objects : Array[TimeSwitchObject]

#these should be pointers
var present_map_node : Node2D
var future_map_node : Node2D

var future = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	present_map_node = $level1present
	
	future_map_node = $level1future
	
#	set visibility and collision
	switch_maps()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

## go from first level to any level
func switch_levels(present : PackedScene, future : PackedScene):
	#present_map = present
	#future_map = future
	present_map_node.change_to_packed_scene(present)
	future_map_node.change_to_packed_scene(future)
	switch_maps()
	
## change the time of the leveL: swap present and future map
func switch_maps():
	print("switching time")
	future = not future
	if (future):
#		careful with the collision as the player may clip into or fall based on the order of ops.
		_enable_map(future_map_node, true)
		_enable_map(present_map_node, false)
	else:
		_enable_map(present_map_node, true)
		_enable_map(future_map_node, false)
	
	request_node_flip()
	
## checks all children, not recursive, for the base time switch objects. 
## scenes need switchable objects to exist only as children on map node and
## switchable objects themselves (they will handle the logic for their own switchable).
## if the player brings switchable objects they should be pointers to the map node children. 
func request_node_flip():
	for c in get_children():
		if c is TimeSwitchObject:
			switchable_objects.append(c)
	
	for objects in switchable_objects:
		objects.switch_object(future)

	
func _enable_map(map : BaseLevel, enable : bool):
#	set visibility of the node in addition to collisions of the tilemap.
	map.visible = enable
	map.enable_TileMapLayer(enable)
#	note: any other collisions will not be disabled. 
	
