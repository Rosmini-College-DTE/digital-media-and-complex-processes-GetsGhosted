extends Node2D

@onready var transition = $fadeoutdeath
var deathmenu = preload("res://scenes/deathmenu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

	
func _on_transition_animation_finished(fade_out):
	get_tree().change_scene_to_packed(deathmenu)

func fade_music():
	$musicfade.play("musicfade")

func _on_fadeshape_area_entered(area):
	$fadeoutdeath.play("fade_out")
