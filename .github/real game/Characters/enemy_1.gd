extends CharacterBody2D

var speed = 45 #the higher the value, the slower it runs
var player_chase = false
var player = null

var health = 80
var player_inattack_zone = false
var can_take_damage = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Timer to control attack intervals
var attack_cooldown = 1.0 # in seconds
var time_since_last_attack = 0.0

func _physics_process(delta):
	deal_with_damage()
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	if player_chase:
		position += (player.position - position)/speed
		
		$AnimatedSprite2D.play("walk")
		
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("idle")

	move_and_slide()

# Handle attacking
	time_since_last_attack += delta
	if player_inattack_zone and time_since_last_attack >= attack_cooldown:
		attack()
		time_since_last_attack = 0.0

func _on_detection_area_body_entered(body):
	$AnimatedSprite2D.play("react")
	player = body
	player_chase = true


func _on_detection_area_body_exited(_body):
	player = null
	player_chase = false
	
func enemy_1():
	pass

func _on_skeleton_hitbox_body_entered(body):
	if body.has_method("player"):
		player_inattack_zone = true

func _on_skeleton_hitbox_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = false
		
func deal_with_damage():
	if player_inattack_zone and Globals.player_current_attack == true:
		if can_take_damage == true:
			health = health - 20
			$TakeDamageCooldown.start()
			can_take_damage = false
			print("Skeleton HP = ", health)
			if health <= 0:
				$AnimatedSprite2D.play("death")
				self.queue_free()

func _on_take_damage_cooldown_timeout():
	can_take_damage = true

func attack():
	print("Attack initiated")  # Added for debugging
	$AnimatedSprite2D.play("attack")  # Play attack animation
	# Add logic to deal damage to the player if within attack range
	if player_inattack_zone and player:
		# Assume player has a method to take damage
		if player.has_method("take_damage"):
			player.take_damage(10) # Example damage value
