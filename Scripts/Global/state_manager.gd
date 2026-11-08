extends Node

enum Level {
	LEVEL_ONE,
	Apartment,
	Lab
}

enum Apartment {
	PLANTS, 
	NO_PLANTS	
}

var player_picked_up_watch = false
var current_level = Level.Apartment
var is_future = true
var ApartmentState = Apartment.PLANTS

var player_picked_up_seed = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
