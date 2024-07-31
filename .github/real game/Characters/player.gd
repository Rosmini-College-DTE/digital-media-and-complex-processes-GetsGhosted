extends CharacterBody2D

var enemy_inattack_range = false
var enemy_attack_cooldown = true
var health = 100
var player_alive = true

var attack_ip = false

@export var speed : float = 200.0
@export var jump_velocity : float = -250.0
@export var double_jump_velocity : float = -175.0

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var actionable_finder: Area2D = $Direction/ActionableFinder

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped : bool = false
var animation_locked : bool = false
var direction : Vector2 = Vector2.ZERO
var was_in_air : bool = false
var current_dir = "none"
var is_dying : bool = false

func _ready():
	Globals.playerAlive = player_alive
	#$AnimatedSprite2D.connect("animation_finished", self, "_on_animation_finished")
	
func _unhandled_input(_event: InputEvent) -> void:  #interact function
	if Input.is_action_just_pressed("interact"):
		var actionables = actionable_finder.get_overlapping_areas()
		if actionables.size() > 0:
			actionables[0].action()
			speed = 0
	else:
		speed = 200
	
func _physics_process(delta):
	enemy_attack()
	attack()
	update_health()
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		was_in_air = true
	else:
		has_double_jumped = false
		was_in_air = false 
	
	if health <= 0:
		player_alive = false #add death menu in future. use get tree function or something
		health = 0
		is_dying = true
		print("You Died") 
		$AnimatedSprite2D.play("death")
		get_tree().change_scene_to_file("res://scenes/deathmenu.tscn")


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
	#player_movement(delta)

func _on_animation_finished(anim_name):
	if anim_name == "death" and is_dying:
		get_tree().change_scene_to_file("res://scenes/deathmenu.tscn")

func player_movement(delta):
	
	if Input.is_action_just_pressed("right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
	if Input.is_action_just_pressed("left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = speed
	else:
		play_anim(0)
		velocity.x = 0

func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("run")
		elif movement == 0:
			anim.play("idle")
	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("run")
		elif movement == 0:
			anim.play("idle")
	
func update_animation(): #update animation of character
	if not animation_locked:
		if attack_ip:
			return # Do nothing, keep playing the attack animation
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
	if(["jump_end", "jump_start", "jump_double", "attack1"].has(animated_sprite.animation)):
		animation_locked = false
		if animated_sprite.animation == "attack1":
			attack_ip = false

func player():
	pass

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy_1"):
		enemy_inattack_range = true

func _on_player_hitbox_body_exited(body):
		if body.has_method("enemy_1"):
			enemy_inattack_range = false

func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown == true:
		#$AnimatedSprite2D.play("hit")
		health = health - 20
		enemy_attack_cooldown = false
		$AttackCooldown.start()
		print(health,"HP")
	
func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true
	
func attack():
	if Input.is_action_just_pressed("attack") and not attack_ip:
		Globals.player_current_attack = true
		attack_ip = true
		animation_locked = true
		
		# Ensure the character faces the correct direction when attacking
		if direction.x != 0:
			animated_sprite.flip_h = direction.x < 0
		
		$AnimatedSprite2D.play("attack1")
		$DealAttackTimer.start()
		
		
func _on_deal_attack_timer_timeout():
	$DealAttackTimer.stop()
	Globals.player_current_attack = false
	attack_ip = false

func update_health():
	var healthbar = $healthbar
	healthbar.value = health
	
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true

func _on_regen_timer_timeout():
	if health < 100:
		health = health + 5
		if health > 100:
			health = 100
	if health <= 0:
		health = 0
	
	
	
	
	
	
