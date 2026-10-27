extends BaseLevel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#	Remember to add every tile map here by name
	define_maps()
	
func define_maps():
	tile_maps = [$TileMapLayer]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)

func enable_TileMapLayer(enable : bool):
	super.enable_TileMapLayer(enable)
