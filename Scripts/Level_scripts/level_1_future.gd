extends "res://Scripts/Level_scripts/base_level.gd"

#use $ to find nodes
#use @export to make it a resource available to all functions.
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)

func get_tile_map_layer() -> TileMapLayer:
	return super.get_tile_map_layer()
