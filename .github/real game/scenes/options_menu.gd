extends Control

@onready var transition = $Transition

func _process(delta):
	position += (get_global_mouse_position()*delta)-position
	
func _ready():
	transition.play("fade_in")

func _on_back_to_menu_pressed():
	self.hide()

