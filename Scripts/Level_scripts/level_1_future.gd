extends BaseLevel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	define_maps()

func define_maps():
	pass
#	Remember to add every tile map here by name
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)
