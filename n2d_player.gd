extends KinematicBody2D;

var player_sprite:  Sprite;
var player_aplayer: AnimationPlayer;

var has_control = true;
var speed       = 180;
var velocity    = Vector2();

func _ready():
	player_sprite = get_node("./Sprite");
	player_aplayer = get_node("./AnimationPlayer");

# warning-ignore:unused_argument
func _process(delta):
	if velocity.x > 0:
		player_sprite.set_flip_h(false);
		
	if velocity.x < 0:
		player_sprite.set_flip_h(true);
		
	if (velocity.x == 0 && velocity.y == 0):
		player_aplayer.stop();
	else:
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
