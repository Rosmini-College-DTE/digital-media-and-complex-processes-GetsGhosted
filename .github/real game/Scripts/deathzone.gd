extends Area2D

class_name KillZone

@onready var deal_damage_zone = $"."

var damage_to_deal = 10000

func _on_area_entered(body):
	get_tree().change_scene_to_file("res://scenes/deathmenu.tscn")
