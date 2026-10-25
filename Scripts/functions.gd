extends Node

# returns bool for player has won
func _has_won(score: int) -> bool:
	if (score >= 100):
		return true
	return false
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(_has_won(5))
	print(_has_won(120))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
