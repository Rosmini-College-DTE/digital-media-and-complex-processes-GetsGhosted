extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$cutsceneAnimation.play("cutscenep1")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_continue_pressed():
	$continuebutton.play()
	get_tree().change_scene_to_file("res://scenes/level_2.tscn")

func _on_skipcutscene_pressed():
	$skipbutton.play()
	get_tree().change_scene_to_file("res://scenes/level_2.tscn")
