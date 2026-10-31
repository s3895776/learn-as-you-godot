class_name MoveComponent
extends Node

@export var gravity : float = 3000.0
@export var speed : float = 100.0
@onready var parent : CharacterBody2D = get_parent()
@export var left_collision_ray: RayCast2D
@export var right_collision_ray: RayCast2D


#be sure to check player is in group ("Player")
var player : Node2D = null
var grabbed: bool = false

#func _input(event: InputEvent) -> void:
##	player's interact: consider player's state. 
## if player.state == idle or player.state == walk
	#if event.is_action_pressed("interact") and _is_interactable():
		#print("try grab in move component gd")
		#
		#grabbed = true
		#_set_player()
		#
	#elif event.is_action_released("interact"):
		#print("try release in move component gd")
		#grabbed = false
		#player = null

func change_states() -> void:
	if not grabbed:
		_set_player()
		grabbed = true
	else:
		grabbed = false
		player = null
	#	if condition, player = null

func _set_player() -> void:
	if player and player.has_method("set_pull_speed"):
		player.set_pull_speed(speed)
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func _physics_process(delta: float) -> void:
	_apply_gravity(delta)
#	TODO: if box falls off, cut off grab.
	
#	do move and slide of parent
	if (grabbed): 
		_push_movement()
		_pull_movement()
		parent.move_and_slide()
	
func _get_collision_normal() -> float:
	if left_collision_ray.is_colliding(): return 1.0
	elif right_collision_ray.is_colliding(): return -1.0
	else: return 0.0

func _is_interactable() -> bool:
	return left_collision_ray.is_colliding() or right_collision_ray.is_colliding()

func _push_movement() -> void:
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction == _get_collision_normal() and direction:
		parent.velocity.x = speed * direction
#		velocity.x = lerp(velocity.x, direction * move_speed, acceleration * delta)

	else:
#		velocity.x = lerp(velocity.x, 0.0, braking * delta)
		parent.velocity.x = 0.0

func _pull_movement() -> void:
	var direction = Input.get_axis("ui_left", "ui_right")
	if grabbed:
		parent.velocity.x = speed * direction

## get player node.
## player cannot disconnect from the box if they are walking into it
func _get_collider_player_node() -> bool:
	for ray : RayCast2D in [left_collision_ray, right_collision_ray]:
#		check if not null first to prevent method call on null type
		if ray.is_colliding() and ray.get_collider().is_in_group("Player"):
			player = ray.get_collider()
			return true
	return false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _apply_gravity(delta: float) -> void:
	if not parent.is_on_floor():
		parent.velocity.y += gravity * delta	
