extends Control

@onready var transition = $Transition

func _ready():
	transition.play("fade_in")

func _on_back_to_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

