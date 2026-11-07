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
signal player_enter_level
signal load_level

# moving player
#signal enter_room
signal move_player
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
