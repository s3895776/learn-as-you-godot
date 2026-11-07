extends CharacterBody2D

var isPast: bool = true



func _physics_process(delta: float) -> void:
	# Add the gravity.-
	if isPast:
		move_and_slide()
