extends Node2D

var state_enabled : bool
#var node : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state_enabled = false
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_enabled(toggle : bool):
	
	if state_enabled and toggle:
		self.show()
		$TileMapLayer.collision_enabled = true
	else:
		self.hide()
		$TileMapLayer.collision_enabled = false
