extends TimeSwitchObject


@onready var moveComponent = $OriginPoint/MoveComponent
@onready var pastObject = $OriginPoint/PastObject
@onready var pastCollision = $OriginPoint/CollisionShape2D
@onready var futureObject = $OriginPoint/FutureObject

var isPast: bool = true
var can_grab: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Events.grabbing.connect(_on_player_grabbing)
	pass # Replace with function body.

func switch_object(future : bool):
	if future:
		pastObject.PROCESS_MODE_DISABLED
		pastCollision.PROCESS_MODE_DISABLED
		pastCollision.disabled = true
		futureObject.PROCESS_MODE_INHERIT
		
	else:
		pastObject.PROCESS_MODE_INHERT
		pastCollision.PROCESS_MODE_INHERIT
		pastCollision.disabled = false
		futureObject.PROCESS_MODE_DISABLED
		
	print("Toggled Pot State")
	

func _physics_process(delta: float) -> void:
	return 
