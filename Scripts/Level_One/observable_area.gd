extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_visibility(false)
	connect_signals()
	pass # Replace with function body.

func connect_signals():
	self.body_entered.connect(_on_body_entered)
	self.body_exited.connect(_on_body_exited)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_visibility(can_see : bool):
	self.visible = can_see
	
# signals
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("yes can observe observable area")
		set_visibility(true)
		#self.visible = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("no can observe observable area")
		set_visibility(false)
		#self.visible = false

	
