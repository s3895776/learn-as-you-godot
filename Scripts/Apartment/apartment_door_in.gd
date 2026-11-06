extends Area2D
@export var apartment_present : PackedScene
@export var apartment_future : PackedScene
@export var apartment_objects : PackedScene


var can_move : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect_signals()
	PositionManager.apartment_door_in_pos = global_position
	pass # Replace with function body.

func connect_signals():
	self.body_entered.connect(_on_body_entered)
	self.body_exited.connect(_on_body_exited)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

## in order: save the level, load the level, call the root object to remove this object. 
func change_level():
	print("change level apartment door")
	Events.load_level.emit(apartment_present, apartment_future, apartment_objects)


func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x, # Vector2 is not supported by JSON
		"pos_y" : position.y
	}
	return save_dict
	
func move_player():
	if can_move:
		var position = PositionManager.apartment_door_out_pos
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
		
