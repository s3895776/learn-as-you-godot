@abstract class_name DoorTeleport
extends Area2D
@onready var up_button: AnimatedSprite2D = $UpButton

var can_move : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect_signals()

func connect_signals():
	self.body_entered.connect(_on_body_entered)
	self.body_exited.connect(_on_body_exited)
	Events.player_enter_level.connect(teleport_player)
	
@abstract func teleport_player()

# signals
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("door can teleport?")
		can_move = true
		up_button.play("UpButton")
		pass

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_move = false
		up_button.play("NOTHING")
		pass

## ensure collision shape2d is named CollisionShape2D
func set_collision(enabled : bool):
	
	monitoring = enabled
