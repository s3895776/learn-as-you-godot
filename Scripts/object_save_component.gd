## use as reference only
extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func save_object():
	var parent: Node2D = get_parent()
	var save_dict = {
		"filename" : parent.get_scene_file_path(),
		"parent" : parent.get_parent().get_path(),
		"pos_x" : parent.position.x, # Vector2 is not supported by JSON
		"pos_y" : parent.position.y
	}
	return save_dict
