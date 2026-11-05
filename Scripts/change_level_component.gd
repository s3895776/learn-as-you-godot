@abstract class_name change_level_component
extends Node2D
@export var area : Area2D
@export var buttons : AnimatedSprite2D
@export var present_level_to_load : PackedScene
@export var future_level_to_load : PackedScene
#@export v


var can_enter : bool

#Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass

@abstract func load_level()

func change_level():
	if (can_enter):
		Events.levels_loaded.emit(present_level_to_load, future_level_to_load)

# signals
func _on_body_entered(body: Node2D) -> void:
	print("yes body level enter")
	if body.is_in_group("Player"):
		can_enter = true

func _on_body_exited(body: Node2D) -> void:
	print("no body level enter ")
	if body.is_in_group("Player"):
		can_enter = false

# getters and setters 

func get_present_level_to_load():
	return present_level_to_load
	
func get_future_level_to_load():
	return future_level_to_load
	

## connect signals (they cannot connect through abstract class)
@abstract func connect_signals()
