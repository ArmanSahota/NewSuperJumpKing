extends CharacterBody2D

# Constants
const SPEED = 300.0
const JUMP_VELOCITY = -600.0

# Variables
var direction = 1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

enum State { IDLE, RUNNING, JUMPUP, HURT }
var anim_state = State.IDLE

# Nodes
@onready var animator = $AnimatedSprite2D
@onready var sprite_2d_player = $AnimationPlayer

func _ready():
	# Ensures the direction starts correctly
	direction = 1

func _physics_process(delta):
	# Apply gravity if not on the floor
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Horizontal movement
	velocity.x = direction * SPEED

	# Move and slide the character
	move_and_slide()

	# Flip sprite based on direction
	animator.flip_h = direction < 0

	# Update state based on velocity and floor condition
	update_state()
	update_animation()

func JumpSnake():
	anim_state = State.JUMPUP
	velocity.y = JUMP_VELOCITY

func _on_timer_timeout():
	# Invert direction and initiate jump
	direction *= -1
	JumpSnake()

func update_state():
	if anim_state == State.HURT:
		return  # No state change if hurt

	if is_on_floor():
		if velocity.x == 0:
			anim_state = State.IDLE
		else:
			anim_state = State.RUNNING
	else:
		anim_state = State.JUMPUP

func update_animation():
	match anim_state:
		State.IDLE:
			sprite_2d_player.play("default")
		State.RUNNING:
			sprite_2d_player.play("default")  # Assuming "run" animation exists
		State.JUMPUP:
			sprite_2d_player.play("Jumpsnake")
		# You might want to add a case for the HURT state if you have such an animation

