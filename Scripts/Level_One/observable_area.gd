extends Area2D

var can_see : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	can_see = false
	connect_signals()
	set_child_visibility()
	pass # Replace with function body.

func connect_signals():
	self.body_entered.connect(_on_body_entered)
	self.body_exited.connect(_on_body_exited)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_child_visibility():
	for child in get_children():
		if child.has_method("set_enabled"):
			child.set_enabled(can_see)
	
# signals
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("yes can observe observable area")
		
		can_see = true
		#self.visible = true
		set_child_visibility()

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("no can observe observable area")
		can_see = false
		#self.visible = false
		set_child_visibility()

	
