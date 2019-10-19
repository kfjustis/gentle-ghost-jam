extends Node

func _ready():
	pass

# warning-ignore:unused_argument
func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
