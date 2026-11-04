# this script handles any signal that travels between different scenes in current map.
extends Node

#inventory signals 
signal grabbing 
signal dropping
signal grab_success
signal dropped_on

# ui signal 
signal draw_ui

# time_switch
signal time_switch

# traverse levels
signal entering_level
signal levels_loaded

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
