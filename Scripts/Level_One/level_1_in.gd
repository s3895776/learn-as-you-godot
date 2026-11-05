extends change_level_component


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func connect_signals():
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)
	Events.entering_level.connect(change_level)

func save():
#	load main, save current state
	Main.save_state_level_one_file
	pass

func change_level():
	save()
	super.change_level()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
