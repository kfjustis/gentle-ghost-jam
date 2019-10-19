extends KinematicBody2D;

var player_sprite:  Sprite;
var player_aplayer: AnimationPlayer;

var has_control: bool    = true;
var frame_index: int     = 0;
var speed      : float   = 180.0;
var velocity   : Vector2 = Vector2();

func _ready():
	player_sprite = get_node("./Sprite");
	player_aplayer = get_node("./AnimationPlayer");

# warning-ignore:unused_argument
func _process(delta):
	if (Input.is_action_just_pressed("player_left")  ||
		Input.is_action_just_pressed("player_right") ||
		Input.is_action_just_pressed("player_up")    ||
		Input.is_action_just_pressed("player_down")):
			# Tapping movement keys should still change the
			# player sprite a little bit, so advance frame
			# by one.
			frame_index += 1;
			if frame_index > (player_sprite.get_hframes() - 1):
				frame_index = 0;
			player_sprite.set_frame(frame_index);

	if velocity.x > 0:
		player_sprite.set_flip_h(false);
		
	if velocity.x < 0:
		player_sprite.set_flip_h(true);
		
	if velocity.x == 0 && velocity.y == 0:
		player_aplayer.stop();
		# .stop() resets to frame 0 which is boring.
		player_sprite.set_frame(frame_index);
	else:
		# Always play animation from frame 0
		if !player_aplayer.is_playing():
			player_sprite.set_frame(0);
		player_aplayer.play("walk_right");

# warning-ignore:unused_argument
func _physics_process(delta):
	get_input();
	velocity = move_and_slide(velocity);

func get_input():
	if !has_control:
		return;
		
	velocity = Vector2();
	
	if Input.is_action_pressed('player_left'):
		velocity.x -= 1
	if Input.is_action_pressed('player_right'):
		velocity.x += 1
	if Input.is_action_pressed('player_up'):
		velocity.y -= 1
	if Input.is_action_pressed('player_down'):
		velocity.y += 1
	velocity = velocity.normalized() * speed
