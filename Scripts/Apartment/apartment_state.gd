extends Node2D

var state_enabled : bool
#var node : Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state_enabled = false
	
	pass # Replace with function body.

func set_enabled():
	
	if state_enabled:
		self.show()
		$TileMapLayer.collision_enabled = true
	else:
		self.hide()
		$TileMapLayer.collision_enabled = false
