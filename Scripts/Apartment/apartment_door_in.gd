extends ChangeLevelComponent
@export var apartment_present : PackedScene
@export var apartment_future : PackedScene
@export var apartment_objects : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect_signals()
	pass # Replace with function body.

func connect_signals():
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)
	Events.entering_level.connect(change_level)
	pass

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
