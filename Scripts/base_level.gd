class_name BaseLevel extends Node2D

#var tile_maps : Array[TileMapLayer]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass

## check all nodes and call set enabled
func enable_map(enabled : bool):
	self.propagate_call("set_enabled", [enabled])
	self.propagate_call("set_collision", [enabled])
