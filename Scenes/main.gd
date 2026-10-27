extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# call current_map to find the correct map
func switch_maps():
#	unload current map
	$CurrentMap.switch_maps()
	
# load both maps
func load_maps():
	pass
