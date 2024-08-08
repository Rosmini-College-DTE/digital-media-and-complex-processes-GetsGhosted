extends Node2D

@onready var transition = $Transition


func _ready():
	transition.play("fade_in")

func _process(_delta):
	pass
