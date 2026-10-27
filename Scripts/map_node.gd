extends Node2D
var present_map : PackedScene = preload("res://Scenes/level1present.tscn")
var future_map : PackedScene = preload("res://Scenes/level1future.tscn")

#these should be pointers
var present_map_node : Node2D
var future_map_node : Node2D

var future = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#change_maps(get_node("res://Scenes/level1present.tscn"), get_node("res://Scenes/level1future.tscn"))
	#present_map.instance
#	get a packed scene instantiated and into a variable for map_node gd
	add_child(present_map.instantiate())
	present_map_node = $level1present
	
#	set visibility and collision
	_enable_map(present_map_node, false)
	
	add_child(future_map.instantiate())
	future_map_node = $level1future
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func switch_maps():
	print("result")
	future = not future
	if (future):
#		careful with the collision as the player may clip into or fall based on the order of ops.
		_enable_map(future_map_node, true)
		_enable_map(present_map_node, false)
	else:
		_enable_map(present_map_node, true)
		_enable_map(future_map_node, false)

func _enable_map(map : Node2D, enable : bool):
#	set visibility of the node in addition to collisions of the tilemap.
	map.visible = enable
	map.get_tile_map_layer().set_enabled(enable)
#	note: any other collisions will not be disabled. 
	
