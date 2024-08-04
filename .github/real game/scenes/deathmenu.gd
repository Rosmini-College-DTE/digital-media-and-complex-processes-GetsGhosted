extends Node2D

@onready var fadeout = $fadeout
var mainMenu = preload("res://scenes/menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$bigfade.play("bigfadein")
	$type1.play("fade in")
	$fade1.play("fadein1")
	$fadebuttons.play("fadebutton1")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_pressed():
	$fadeout.play("fadeout")
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_fadeout_animation_finished(fadeout):
	get_tree().change_scene_to_packed(mainMenu)

func _on_quit_pressed():
	get_tree().quit()
