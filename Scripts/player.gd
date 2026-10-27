extends CharacterBody2D
@onready var sprite: Sprite2D = $Sprite
@onready var anim : AnimationPlayer = $AnimationPlayer
@onready var animated_sprite = $AnimatedSprite2D

const move_speed = 250.0
const JUMP_VELOCITY = -300.0
var acceleration = 50
var braking = 20
var direction : float

#time travel feature: switch between maps.
func switch_maps():
#	from main.gd perform switch maps
	get_node(get_tree().get_current_scene().get_path()).switch_maps()
			

func _ready():
#	tag system: group will identify the player.
	add_to_group("Player")

func _manage_animation():
	if not is_on_floor():
		#animated_sprite.play("jump")
		pass
	elif direction != 0:
		animated_sprite.play("Walk")
		animated_sprite.flip_h = direction < 0
	else:
		animated_sprite.play("Idle")

func _process(delta: float) -> void:
	
	_manage_animation()
	
func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	direction = Input.get_axis("move_left", "move_right")
	if velocity.x != 0:
		animated_sprite.flip_h = velocity.x > 0
	
	#velocity.x = move_input * move_speed
	
	#lerp 
	if direction != 0:
		velocity.x = lerp(velocity.x, direction * move_speed, acceleration * delta)
	else:
		velocity.x = lerp(velocity.x, 0.0, braking * delta)
		
	if Input.is_action_just_pressed("switch_map"):
		switch_maps()
	#var direction := Input.get_axis("move_left", "move_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
