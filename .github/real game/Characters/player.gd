extends CharacterBody2D

@export var speed : float = 200.0
@export var jump_velocity : float = -200.0
@export var double_jump_velocity : float = -175.0

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var actionable_finder: Area2D = $Direction/ActionableFinder

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped : bool = false
var animation_locked : bool = false
var direction : Vector2 = Vector2.ZERO
var was_in_air : bool = false

#var attack_type: String
#var current_attack: bool

#  #func _ready():
	#current_attack = false

func _unhandled_input(_event: InputEvent) -> void:  #interact function
	if Input.is_action_just_pressed("interact"):
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action()
			return

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		was_in_air = true
	else:
		has_double_jumped = false
		was_in_air = false 

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			#normal jump from floor
			jump()
		elif not has_double_jumped:
			# double jump in air
			double_jump()
			

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left", "right", "up", "down")
	if direction:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()
	update_animation()
	update_facing_direction()

func update_animation(): #update animation of character
	if not animation_locked:
		if not is_on_floor():
			animated_sprite.play("jump_loop")
		else:
			if direction.x != 0:
				animated_sprite.play("run")
			else:
				animated_sprite.play("idle")
			
func update_facing_direction(): #change direction character faces
	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.flip_h = true
		
func jump(): #jump
	velocity.y = jump_velocity
	animated_sprite.play("jump_start")
	animation_locked = true
	
func double_jump(): #double jump function
	velocity.y = double_jump_velocity
	animated_sprite.play("jump_double")
	animation_locked = true
	has_double_jumped = true
	
func _on_animated_sprite_2d_animation_finished(): #jump animation ends once landed
	if(["jump_end", "jump_start", "jump_double"].has(animated_sprite.animation)):
		animation_locked = false 
