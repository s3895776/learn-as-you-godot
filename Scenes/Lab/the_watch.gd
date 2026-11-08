extends Node2D

var player : Node2D
var pickup_able = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (StateManager.player_picked_up_watch):
		queue_free()
	$Area2D.body_entered.connect(_on_body_entered)
	$Area2D.body_exited.connect(_on_body_exited)
	$AnimatedSprite2D.play("FButton")
	pass # Replace with function body.

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = body
		pickup_able = true
		print(pickup_able)

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = null
		pickup_able = false

func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("switch_map")):
		pickup()
	

func pickup():
	if pickup_able:
		StateManager.player_picked_up_watch = true
		player.picked_up_watch = true
#		force on ability, will not overlap with state management. 
		player.on_ability()
		queue_free()
