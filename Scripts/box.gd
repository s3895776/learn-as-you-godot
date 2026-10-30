extends CharacterBody2D

signal grab
var can_grab: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

## allow this object to move back or forward from the player by reparenting

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_grab = true
	grab.emit(can_grab)
	print("can grab")

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_grab = false
	grab.emit(can_grab)
	print("no grab")
	
func set_collision(no_col : bool):
	$Area2D/CollisionShape2D.disabled = no_col
