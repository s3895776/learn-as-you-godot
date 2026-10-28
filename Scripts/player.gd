extends CharacterBody2D
@onready var sprite: Sprite2D = $Sprite
@onready var anim : AnimationPlayer = $AnimationPlayer
@onready var animated_sprite = $AnimatedSprite2D

const move_speed = 250.0
const JUMP_VELOCITY = -300.0
var acceleration = 50
var braking = 20
var direction : float
var face =  1  #0 is left, 1 is right

enum States {NULL, IDLE, WALK, JUMP, ABILITY, PUSH, PULL}

var state: States = States.NULL

#time travel feature: switch between maps.
func switch_maps():
#	from main.gd perform switch maps
	get_node(get_tree().get_current_scene().get_path()).switch_maps()
			

func _ready():
#	tag system: group will identify the player.
	add_to_group("Player")

func _manage_animation():
	
	if state == States.IDLE:
			animated_sprite.play("Idle")
			animated_sprite.flip_h = face == 0
	elif state == States.WALK:
		animated_sprite.play("Walk")
		animated_sprite.flip_h = direction < 0
	elif state == States.JUMP:
		animated_sprite.play("Jump")
	elif state == States.ABILITY:
		animated_sprite.play("Ability")
	elif state == States.PUSH:
		animated_sprite.play("Push")
	elif state == States.PULL:
		animated_sprite.play("Pull")

func state_changer():
	
	if state == States.NULL:
		state = States.IDLE
		_manage_animation()
	
	if (state == States.IDLE and is_on_floor() and Input.is_action_just_pressed("switch_map")):
		state = States.ABILITY
		_manage_animation()
	
	if state == States.ABILITY:
		await animated_sprite.animation_finished
		print("COMPLETE")
		print("WAIT")
		state = States.IDLE
		_manage_animation()
		#switch_maps()
		
	if state == States.IDLE and direction != 0:
		state = States.WALK
		if direction < 0:
			face = 0
		else:
			face = 1
		_manage_animation()
			
	if state == States.WALK and direction == 0:
		state = States.IDLE
		_manage_animation()
		
	if state == States.IDLE and velocity.y != 0:
		state = States.JUMP
		_manage_animation()
	
	if state == States.JUMP and is_on_floor():
		state = States.IDLE
		_manage_animation()
		
	if state == States.WALK and velocity.y != 0:
		state = States.JUMP
		_manage_animation()
	
		#Original
	#if not is_on_floor():
		#animated_sprite.play("Jump")
		#pass
	#elif direction != 0:
		#animated_sprite.play("Walk")
		#animated_sprite.flip_h = direction < 0
	#else:
		#animated_sprite.play("Idle")

func _process(delta: float) -> void:
	
	_manage_animation()
	
func _physics_process(delta: float) -> void:
	
	state_changer()
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	direction = Input.get_axis("move_left", "move_right")
	#if velocity.x != 0:
		#animated_sprite.flip_h = velocity.x > 0
	
	#velocity.x = move_input * move_speed
	
	#lerp 
	if direction != 0:
		velocity.x = lerp(velocity.x, direction * move_speed, acceleration * delta)
	else:
		velocity.x = lerp(velocity.x, 0.0, braking * delta)
		
		#func _physics_process(delta: float) -> void:
	
	#var time_warping := is_on_floor() and Input.is_action_just_pressed("switch_map")
	#if time_warping:
		#state == States.TIME
		#trying to make it recognise between not pressing anything for idle and not pressing anything while trying to time warp
	#elif 
		
	#var time_warp := false
	#if is_on_floor() and Input.is_action_just_pressed("switch_map"): 
			##time_warp = true
	##if time_warp:
		#animated_sprite.play("Ability")
		#await $AnimatedSprite2D.animation_finished
		#switch_maps()
	#var direction := Input.get_axis("move_left", "move_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
