extends Node

var player_current_attack = false 
var DialogueChangeScene = false
var playerAlive : bool

func onSwitchScene():
	get_tree().change_scene_to_file("res://scenes/level_2.tscn")

	
