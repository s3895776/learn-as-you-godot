@abstract class_name BaseLevel extends Node2D

var tile_maps : Array[TileMapLayer]

# Called when the node enters the scene tree for the first time.
@abstract func _ready() -> void

## each level must define their own tile_maps.
@abstract func define_maps()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# enable and disable tile maps: access all tileMaps with an array (extended classes)
# alternative: find all child nodes on runtime and check if they are a tilemap 
# to add to a tilemap array. Docs Notes: could be extremely slow to run find_children().
# for all tilemap nodes in tile map array, change the visibility of the tilemap.
func enable_TileMapLayer(enable : bool):
	for map in tile_maps:
		map.set_enabled(enable)
