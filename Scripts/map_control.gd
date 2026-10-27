extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# map control script should control all levels. circular behaviour is not allowed in godot. 
func toggle_map(level : Node2D) -> void:
	var map : String = level.get_other_map()
	remove_child(level)
	load(map).instance()
