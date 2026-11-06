extends CharacterBody2D
@onready var animated_sprite = $AnimatedSprite2D
@export var inventory: Inventory
@onready var fade: CanvasLayer = $Fade
@onready var time_screen_anim: AnimationPlayer = $TimeWarp/ColorRect/AnimationPlayer

# sounds
@onready var footsteps: AudioStreamPlayer = $Sounds/Footsteps
var step_interval: float = 0.5
var step_timer: float = 0.0

@onready var jump: AudioStreamPlayer2D = $Sounds/Jump
@onready var time_ability: AudioStreamPlayer2D = $"Sounds/Time Ability"


const move_speed = 250.0
var pull_speed = 100.0
var time_speed = 25.0
const JUMP_VELOCITY = -325.0
var acceleration = 50
var braking = 20
var direction : float
#var stop : bool = false
@export var left_collision_ray: RayCast2D
@export var right_collision_ray: RayCast2D


enum States {IDLE, WALK, JUMP, STOP, PUSH, PULL, PUSH_IDLE, CROUCH}

var state: States = States.IDLE
var can_switch = true

#time travel feature: switch between maps.

	
func _ready():
#	tag system: group will identify the player.
	add_to_group("Player")
	
#	set your character to idle
	state_changer()
	Events.grab_success.connect(_on_box_grab_success)
	Events.move_player.connect(move_player)

func move_player(position : Vector2):
	print('move player in player script')
	self.position = position
	
func switch_maps():
#	emit signal
	#print("Switch maps signal player")
	Events.time_switch.emit()
			
func enter_room():
#	the collision will have the level pointer. 
	Events.enter_room.emit()
	
func _manage_animation():
	if state == States.STOP:
		pass
	elif state == States.IDLE:
		animated_sprite.play("Idle")
		$ExtraFX.play("NOTHING")
	elif state == States.CROUCH:
		animated_sprite.play("Crouch")
		$ExtraFX.play("NOTHING")
	elif state == States.WALK:
		animated_sprite.play("Walk")
		$ExtraFX.play("NOTHING")
		animated_sprite.flip_h = direction < 0
	elif state == States.JUMP:
		animated_sprite.play("Jump")
		$ExtraFX.play("NOTHING")
	elif state == States.PUSH:
		animated_sprite.play("Push")
		$ExtraFX.play("Sweat")
	elif state == States.PULL:
		animated_sprite.play("Pull")
		$ExtraFX.play("Sweat")
	elif state == States.PUSH_IDLE:
		animated_sprite.play("PushIdle")
		$ExtraFX.play("NOTHING")
			
func _manage_sound():
	#if state == States.STOP:
		#$Footsteps.play()
	#elif state == States.IDLE:
		#$Footsteps.play()
	#elif state == States.CROUCH:
		#$Footsteps.play()
	#elif state == States.JUMP:
		#$Footsteps.play()
	#elif state == States.PUSH:
		#$Footsteps.play()
	#elif state == States.PULL:
		#$Footsteps.play()
	#elif state == States.PUSH_IDLE:
		#$Footsteps.play()
		
		# loops footsteps audio
	if state == States.WALK:
		await footsteps.finished
		if not footsteps.playing:
			footsteps.play()
		_manage_sound()
		return
	
	elif state == States.IDLE:
		footsteps.stop()
	
	elif state == States.JUMP:
		footsteps.stop()
	

func state_changer():
	if state == States.STOP:
		pass
#		to walk states
	elif state == States.IDLE and direction != 0:
		state = States.WALK
		footsteps.play()
		_manage_sound()
		
		
	elif state == States.CROUCH and direction != 0:
		state = States.WALK
		
#		to crouch states
	elif state == States.IDLE and Input.is_action_pressed("move_down"):
		state = States.CROUCH

#		to idle states 
	elif state == States.WALK and direction == 0:
		state = States.IDLE
		
	elif state == States.CROUCH and Input.is_action_just_released("move_down"):
		state = States.IDLE
		
	elif state == States.JUMP and is_on_floor():
		state = States.IDLE
		
#			to jump states 
	elif state == States.IDLE and velocity.y != 0:
		state = States.JUMP
		
	elif state == States.WALK and velocity.y != 0:
		state = States.JUMP
		
	elif state == States.CROUCH and velocity.y != 0:
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
	if self.has_player_item():
		inventory.drop_item()
	Events.grabbing.emit()
	
func reload_level():
#	only applies for first level
	Events.entering_level.emit(StateManager.Level.LEVEL_ONE)
	

func _can_switch_time():
	if (state != States.STOP and not has_player_item()):
		return true
	return false
	
func on_ability():
	state = States.STOP
#		want to play ability ONCE and prevent animation from playing again
	animated_sprite.play("Ability")
	time_ability.play()
	$ExtraFX.play("Shine")
#		animation is never finish and this will wait forever for the call. 

	#fade.fade(1.0, 0.5)
	
	await animated_sprite.animation_finished
	time_screen_anim.play("TIME FADE")
	await time_screen_anim.animation_finished
	switch_maps()
	time_screen_anim.play("TIME FADE OUT")
	
	#fade.fade(0.0, 0.5)
	
	state = States.IDLE
		
func _process(delta: float) -> void:
	pass

var push_states = [States.PUSH_IDLE, States.PUSH, States.PULL]
func _physics_process(delta: float) -> void:
	# Time warp stops all
	if state == States.STOP:
		return
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and (state not in push_states):
		velocity.y = JUMP_VELOCITY
		jump.play()
	
#	perform time switch, can't be in push states.
	if Input.is_action_just_pressed("switch_map") and (state not in push_states):
#		conditions for getting stop state
		if (_can_switch_time()):
			on_ability()
	
#	must be on the ground to interact
	elif Input.is_action_just_pressed("interact") and is_on_floor():
		on_interact()
		
	elif Input.is_action_just_pressed("ui_up") and is_on_floor():
		enter_room()
	
	elif Input.is_action_just_pressed("reload"):
		reload_level()
	
	# Get the input direction and handle the movement/deceleration.
	direction = Input.get_axis("move_left", "move_right")
		
	# lerping, calculate movement speed.
	if direction != 0:
		velocity.x = lerp(velocity.x, direction * move_speed, acceleration * delta)
		if (state in push_states):
			velocity.x = pull_speed * direction
			print(direction)
		if state == States.STOP:
			velocity.x = time_speed * direction
	else:
		velocity.x = lerp(velocity.x, 0.0, braking * delta)
		if (state in push_states):
			velocity.x = 0
		
	state_changer()
	_manage_animation()
	move_and_slide()

func set_pull_speed(value: float) -> void:
	pull_speed = value
	
func set_time_speed(value: float) -> void:
	time_speed = value
	
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
		
func get_player_inventory():
	return inventory.get_inventory()

func has_player_item():
	return inventory.has_item()
