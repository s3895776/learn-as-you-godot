extends BaseLevel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	define_maps()
	
func define_maps():
#	Remember to add every tile map here by name
	tile_maps = [$TileMapLayer]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)

func enable_TileMapLayer(enable : bool):
	super.enable_TileMapLayer(enable)
