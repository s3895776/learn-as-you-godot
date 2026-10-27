extends Node2D
@export var toggle_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# each map will handle toggle data (alternate is to have a map control script for all maps)
func toggle_map():
	get_tree().change_scene_to_packed(toggle_scene)
