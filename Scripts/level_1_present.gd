extends Node2D

#use $ to find nodes
#use @export to make it a resource available to all functions.
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_tile_map_layer() -> TileMapLayer:
	return $TileMapLayer
