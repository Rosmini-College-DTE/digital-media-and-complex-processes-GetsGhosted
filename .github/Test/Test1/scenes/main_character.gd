extends CharacterBody2D

var speed = 300

var player_state 

func _physics_process(delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if direction.x == 0 and direction.y ==0:
		player_state ="idle"
	elif direction.x !=0 or direction.y != 0:
		player_state = "walking"
		
	velocity = direction * speed
	move_and_slide()
 
