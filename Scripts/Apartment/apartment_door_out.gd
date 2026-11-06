extends Area2D

var can_move : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect_signals()
	PositionManager.apartment_door_out_pos = global_position
	pass # Replace with function body.

func connect_signals():
	self.body_entered.connect(_on_body_entered)
	self.body_exited.connect(_on_body_exited)
	Events.enter_room.connect(move_player)

func move_player():
	if can_move:
#		i don't like hard coded values
		var position = PositionManager.apartment_door_in_pos
		Events.move_player.emit(position)
		
# signals
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_move = true
		pass

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_move = false
		pass
		
