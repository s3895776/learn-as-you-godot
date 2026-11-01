extends CharacterBody2D

# Raycast for Button
@onready var Lraycast: RayCast2D = $LeftSideButton
@onready var Rraycast: RayCast2D = $RightSideButton

#signal grab
signal grab_success

var can_grab: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

### allow this object to move back or forward from the player by reparenting
#
#func _on_area_2d_body_entered(body: Node2D) -> void:
	#if body.is_in_group("Player"):
		#can_grab = true
	#grab.emit(can_grab)
	#print("can grab")
#
#func _on_area_2d_body_exited(body: Node2D) -> void:
	#if body.is_in_group("Player"):
		#can_grab = false
	#grab.emit(can_grab)
	#print("no grab")
	
#func set_collision(no_col : bool):
	#$Area2D/CollisionShape2D.disabled = no_col
	#$CollisionShape2D.disabled = no_col

func _physics_process(delta: float) -> void:
	# checks raycasts to see if player is near
	if Lraycast.is_colliding():
		var Lhit_object = Lraycast.get_collider()
		if Lhit_object.is_in_group("Player"):
			$Buttons.play("QButton")
		else:
			$Buttons.play("NOTHING")
	
	elif Rraycast.is_colliding():
		var Rhit_object = Rraycast.get_collider()
		if Rhit_object.is_in_group("Player"):
			$Buttons.play("QButton")
		else:
			$Buttons.play("NOTHING")
	else:
		$Buttons.play("NOTHING")


func _on_player_grabbing() -> void:
#	check player existence. Move component will also set player immediately. 
	var player_exists = $MoveComponent._get_collider_player_node()
	if (player_exists):
		$MoveComponent.change_states()
		grab_success.emit()
	pass # Replace with function body.
