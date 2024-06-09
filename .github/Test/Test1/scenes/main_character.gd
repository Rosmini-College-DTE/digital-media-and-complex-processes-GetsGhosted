extends CharacterBody2D

var speed = 300

var player_state 

func _physics_process(delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if direction.x == 0 and direction.y == 0:
		player_state ="idle"
	elif direction.x !=0 or direction.y != 0:
		player_state = "running"
	elif direction.x !=1 or direction.y != 1:
		player_state = "opp-running"
		
	velocity = direction * speed
	move_and_slide()



	play_anim(direction)
	
func play_anim(dir):
	if player_state == "idle":
		$Sprite2D.play("idle")
	if player_state == "running":
		$Sprite2D.play("running")
		if dir.x == -1:
			$Sprite2D.play("opp-running")
