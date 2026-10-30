extends Area2D

var can_grab: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

## allow this object to move back or forward from the player by reparenting
func can_reparent():
	# can reparent?
	return can_grab

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_grab = false
		

func _on_body_entered(body: Node2D) -> void:
	#	otherside requires to be in the tag "Player" assigned by the dev. 
	if body.is_in_group("Player"):
		can_grab = true
