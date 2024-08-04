extends Control

@onready var transition = $Transition
var level1 = preload("res://scenes/level_1.tscn")

func _process(delta):
	position += (get_global_mouse_position()*delta)-position

func _ready():
	$fadein.play("fadein")

func _on_play_pressed():
	transition.play("fade_out")
	#get_tree().change_scene_to_file("res://scenes/level_1.tscn")

func _on_transition_animation_finished(_anim_name):
	get_tree().change_scene_to_packed(level1)

func _on_options_pressed():
	var options = load("res://scenes/options_menu.tscn").instantiate()
	get_tree().current_scene.add_child(options)


func _on_quit_game_pressed():
	get_tree().quit()
	
	
	



