extends Area2D

class_name KillZone

@onready var deal_damage_zone = $"."

#@onready var transition = $Transition
#var deathmenu = preload("res://scenes/deathmenu.tscn")

#func _on_play_pressed():
#	transition.play("fade_in")
	#get_tree().change_scene_to_file("res://scenes/level_1.tscn")

var damage_to_deal = 10000


func _on_area_entered(_body):
	#transition.play("fade_out")
	get_tree().change_scene_to_file("res://scenes/deathmenu.tscn")
