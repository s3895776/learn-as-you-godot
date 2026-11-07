extends CharacterBody2D

# Raycast for Button
#@onready var Lraycast: RayCast2D = $LeftSideButton
#@onready var Rraycast: RayCast2D = $RightSideButton

var can_grab: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("Persist")
	#Events.grabbing.connect(_on_player_grabbing)
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	# checks raycasts to see if player is near
	#if Lraycast.is_colliding():
		#var Lhit_object = Lraycast.get_collider()
		#if Lhit_object.is_in_group("Player"):
			#$Buttons.play("QButton")
		#else:
			#$Buttons.play("NOTHING")
	#
	#elif Rraycast.is_colliding():
		#var Rhit_object = Rraycast.get_collider()
		#if Rhit_object.is_in_group("Player"):
			#$Buttons.play("QButton")
		#else:
			#$Buttons.play("NOTHING")
	#else:
		#$Buttons.play("NOTHING")
	return 

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x, # Vector2 is not supported by JSON
		"pos_y" : position.y
	}
	return save_dict
