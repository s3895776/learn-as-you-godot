extends SaveLevelComponent


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#	get the variable type
	super._ready()
#	should return "Saves"
	#print(self.get_groups())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func save_level():
#	give both file name and root
	pass
	#saves.save_state(Main.Levels.LEVEL_ONE, get_parent())
