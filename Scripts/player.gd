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
var stop : bool = false
signal grabbing

enum States {NULL, IDLE, WALK, JUMP, ABILITY, PUSH, PULL}

var state: States = States.NULL

#time travel feature: switch between maps.
func switch_maps():
#	from main.gd perform switch maps
	get_node(get_tree().get_current_scene().get_path()).switch_maps()
			

func _ready():
#	tag system: group will identify the player.
	add_to_group("Player")
	
#	set your character to idle
	state_changer()
	

func _manage_animation():
	if not stop: 
		if state == States.IDLE:
			animated_sprite.play("Idle")
			animated_sprite.flip_h = face == 0
		elif state == States.WALK:
			animated_sprite.play("Walk")
			animated_sprite.flip_h = direction < 0
		elif state == States.JUMP:
			animated_sprite.play("Jump")
		elif state == States.PUSH:
			animated_sprite.play("Push")
		elif state == States.PULL:
			animated_sprite.play("Pull")

func interact():
#	if grabbing something, emit false
# 	if not grabbing something, emit true. 
# 	requires response from map_node. 
	grabbing.emit()
		
	

func state_changer():
	if not stop:
		if state == States.NULL:
			state = States.IDLE
			
		elif state == States.IDLE and direction != 0:
			state = States.WALK
			if direction < 0:
				face = 0
			else:
				face = 1
				
		elif state == States.WALK and direction == 0:
			state = States.IDLE
			
		elif state == States.IDLE and velocity.y != 0:
			state = States.JUMP
		
		elif state == States.JUMP and is_on_floor():
			state = States.IDLE
			
		elif state == States.WALK and velocity.y != 0:
			state = States.JUMP
		
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
	pass
	
func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
#	perform time switch
	if Input.is_action_just_pressed("switch_map"):
		if (state != States.ABILITY):
			state = States.ABILITY
	#		want to play ability ONCE and prevent animation from playing again
			animated_sprite.play("Ability")
			stop = true
	#		animation is never finish and this will wait forever for the call. 
			await animated_sprite.animation_finished
			stop = false
			switch_maps()
			state = States.IDLE
	
	if Input.is_action_just_pressed("interact"):
		interact()
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("move_left", "move_right")
	
	
	
	# lerping
	if direction != 0:
		velocity.x = lerp(velocity.x, direction * move_speed, acceleration * delta)
	else:
		velocity.x = lerp(velocity.x, 0.0, braking * delta)
		
	state_changer()
	_manage_animation()
	move_and_slide()

func _on_map_node_grab_success() -> void:
#	change the state of the player to push / pull 
# 	change the state of the player to normal. 
	pass # Replace with function body.
