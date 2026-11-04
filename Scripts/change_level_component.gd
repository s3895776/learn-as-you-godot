@abstract class_name change_level_component
extends Node2D
@export var area : Area2D
@export var buttons : AnimatedSprite2D
@export var present_level_to_load : PackedScene
@export var future_level_to_load : PackedScene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# getters and setters 

func get_present_level_to_load():
	return present_level_to_load
	
func get_future_level_to_load():
	return future_level_to_load
	
	
