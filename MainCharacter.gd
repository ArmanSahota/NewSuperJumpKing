extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -25.0
const MAX_CHARGE = 0.5  # Adjust this value as needed (higher values mean longer charge)
const minJumpSpeed = 5
const maxJumpSpeed = 22
const jumpSpeedHorizontal = 8
const terminalVelocity = 20
const MAX_JUMP_HEIGHT = -850 
const WALL_JUMP_FORCE = 300




@onready var sprite_2d = $Sprite2D
var charge_time = 0.0
var is_charging = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Animations
	if abs(velocity.x) > 1:
		sprite_2d.animation = "running"
	else:
		sprite_2d.animation = "default"

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0

	# Handle jump charge.
	if Input.is_action_pressed("jump") and is_on_floor():
		is_charging = true
		charge_time += delta
		sprite_2d.animation = "charge"  # Play the charge animation
		
	elif is_charging:
		# Release jump key: Jump with charge proportional to charge_time
		jump()
		sprite_2d.animation = "jumping"
		is_charging = false
		charge_time = 0.0
		
	# Get the input direction and handle movement/deceleration.
	var direction = Input.get_axis("left", "right")
	if direction and is_on_floor():
		velocity.x = direction * SPEED
		if Input.is_action_pressed("jump") and is_on_floor():
			velocity.x = 0
	elif is_on_floor():
		velocity.x = move_toward(velocity.x, 0, 15)
	
	var isLeft = velocity.x < 0
	
	
	
	if is_on_wall() and not is_on_floor():
		if sprite_2d.is_flipped_h():
			velocity.x = WALL_JUMP_FORCE
			
		elif not sprite_2d.is_flipped_h():  # Character is moving left
			velocity.x = -WALL_JUMP_FORCE
			
			
	move_and_slide()

	
	sprite_2d.flip_h = isLeft
	
	
func jump():
	var vertical_jump_speed = lerp(minJumpSpeed, maxJumpSpeed, charge_time / MAX_CHARGE) * JUMP_VELOCITY  # Multiply by JUMP_VELOCITY to control jump speed
	
	# Cap the vertical jump speed
	if vertical_jump_speed < MAX_JUMP_HEIGHT:
		vertical_jump_speed = MAX_JUMP_HEIGHT
	
	if Input.is_action_pressed("left"):
		velocity = Vector2(-jumpSpeedHorizontal, vertical_jump_speed)
	elif Input.is_action_pressed("right"):
		velocity = Vector2(jumpSpeedHorizontal, vertical_jump_speed)
	else:
		velocity.y = vertical_jump_speed
	
		

func swing():
	if Input.is_action_pressed("swing"):
		sprite_2d.animation = "swing"


func _on_area_2d_body_entered(body):
	pass # Replace with function body.
