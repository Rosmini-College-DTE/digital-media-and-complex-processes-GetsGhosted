extends Node

var player_current_attack = false 
var DialogueChangeScene = false
var playerAlive : bool

func onSwitchCutScene():
	get_tree().change_scene_to_file("res://scenes/cutscene_1.tscn")
	
func onSwitchToEndScreen():
	get_tree().change_scene_to_file("res://scenes/end_screen.tscn")

	
