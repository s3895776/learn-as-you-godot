extends CharacterBody2D
@onready var sprite: Sprite2D = $Sprite
@onready var anim : AnimationPlayer = $AnimationPlayer
@onready var animated_sprite = $AnimatedSprite2D

const move_speed = 250.0
var pull_speed = 100.0
const JUMP_VELOCITY = -300.0
var acceleration = 50
var braking = 20
var direction : float
#var stop : bool = false
@export var left_collision_ray: RayCast2D
@export var right_collision_ray: RayCast2D

signal grabbing

enum States {IDLE, WALK, JUMP, STOP, PUSH, PULL, PUSH_IDLE}

var state: States = States.IDLE

#time travel feature: switch between maps.
func switch_maps():
#	from main.gd perform switch maps
	get_node(get_tree().get_current_scene().get_path()).switch_maps()
			

func _ready():
#	tag system: group will identify the player.
	add_to_group("Player")
	
#	set your character to idle
	state_changer()
	
#Original animations
	#if not is_on_floor():
		#animated_sprite.play("Jump")
		#pass
	#elif direction != 0:
		#animated_sprite.play("Walk")
		#animated_sprite.flip_h = direction < 0
	#else:
		#animated_sprite.play("Idle")
func _manage_animation():
	if state == States.STOP:
		pass
	elif state == States.IDLE:
		animated_sprite.play("Idle")
	elif state == States.WALK:
		animated_sprite.play("Walk")
		animated_sprite.flip_h = direction < 0
	elif state == States.JUMP:
		animated_sprite.play("Jump")
	elif state == States.PUSH:
		animated_sprite.play("Push")
	elif state == States.PULL:
		animated_sprite.play("Pull")
#	todo: push idle animation.
			
func state_changer():
	if state == States.STOP:
		pass
#		to walk states
	elif state == States.IDLE and direction != 0:
		state = States.WALK

#		to idle states 
	elif state == States.WALK and direction == 0:
		state = States.IDLE
		
	elif state == States.JUMP and is_on_floor():
		state = States.IDLE
		
#			to jump states 
	elif state == States.IDLE and velocity.y != 0:
		state = States.JUMP
		
	elif state == States.WALK and velocity.y != 0:
		state = States.JUMP
		
#		push and pull states moves (requires interact to move into push state
	elif (state in push_states) and direction == 0:
		state = States.PUSH_IDLE
#		TODO: if pushing a box (box location and direction are same), 
	elif (state in push_states) and direction == get_box_side():
		print("Push")
		state = States.PUSH
#		TODO: if pulling a box ( box to player is not the same)
	elif (state in push_states) and direction != get_box_side():
		print("Pull")
		state = States.PULL
	
func on_interact():
#	emit something to someone
#	the other side will have to get true, then return the signal.
#	alternative is to have ray colliders and grab whatever's close by
#	which honestly is pretty good idea.
	grabbing.emit()
	
	
func on_ability():
	state = States.STOP
#		want to play ability ONCE and prevent animation from playing again
	animated_sprite.play("Ability")
#		animation is never finish and this will wait forever for the call. 
	await animated_sprite.animation_finished
	switch_maps()
	state = States.IDLE
		
func _process(delta: float) -> void:
	pass

var push_states = [States.PUSH_IDLE, States.PUSH, States.PULL]
func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and (state not in push_states):
		velocity.y = JUMP_VELOCITY
	
#	perform time switch, can't be in push states.
	if Input.is_action_just_pressed("switch_map") and (state not in push_states):
		if (state != States.STOP):
			on_ability()
	
#	must be on the ground
	elif Input.is_action_just_pressed("interact") and is_on_floor():
		on_interact()
	
	# Get the input direction and handle the movement/deceleration.
	direction = Input.get_axis("move_left", "move_right")
		
	# lerping, calculate movement speed.
	if direction != 0:
		velocity.x = lerp(velocity.x, direction * move_speed, acceleration * delta)
		if (state in push_states):
			velocity.x = pull_speed * direction
			print(direction)
	else:
		velocity.x = lerp(velocity.x, 0.0, braking * delta)
		if (state in push_states):
			velocity.x = 0
		
	state_changer()
	_manage_animation()
	move_and_slide()

func set_pull_speed(value: float) -> void:
	pull_speed = value
	
func get_box_side() -> float:
	if left_collision_ray.is_colliding(): return -1.0
	elif right_collision_ray.is_colliding(): return 1.0
	else: return 0.0

func _on_box_grab_success() -> void:
#	change push or pull states. 
	if (state not in push_states):
		state = States.PUSH_IDLE
	else:
		state = States.IDLE
