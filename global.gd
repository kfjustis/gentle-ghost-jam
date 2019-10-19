extends Node

func _ready():
	OS.set_window_always_on_top(true);

# warning-ignore:unused_argument
func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()

	if Input.is_action_just_released("toggle_fullscreen"):
			OS.window_fullscreen = !OS.window_fullscreen;
