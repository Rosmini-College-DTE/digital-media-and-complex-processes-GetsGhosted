extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$text1.play("fadetext1")
	$text2.play("fadetext2")
	$creditLeftSide.play("left")
	$creditRightSide.play("right")
	$creditmiddle.play("middle")
	$bibleverse.play("fadeverse")
	$charity.play("charityfade")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
