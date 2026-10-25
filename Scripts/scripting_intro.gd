extends Node2D

var score : int = 0
var country_name : String = "Aus"
var population : int = 100000  
var highest_altitude : float = 2.228
var landlocked : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(score) # Replace with function body.
	score = 20
	print(score)
	print(country_name) 
	print(population) 
	print(highest_altitude) 
	print(landlocked)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
