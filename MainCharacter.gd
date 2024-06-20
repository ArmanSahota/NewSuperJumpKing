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
var attack_cooldown = 0.5  # Adjust this value as needed
var last_attack_time = 0.0

@onready var game_manager = %GameManager
@onready var door = %Door
@onready var area_2d = $Area2D
@onready var swing_shape_2d = $Area2D/swingShape2D

@onready var start_pos = global_position

func reset():
	global_position = start_pos
	set_physics_process(true)
	anim_state = state.IDLE
	
	get_tree().reload_current_scene()
	

enum state {IDLE, RUNNING, JUMPUP, JUMPDOWN, HURT, CHARGE, INTODOOR, ATTACK}

@onready var animator = $Sprite2D
@onready var sprite_2d_player = $AnimationPlayer
var charge_time = 0.0
var is_charging = false
var anim_state = state.IDLE	
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# update state
func update_state():
	if anim_state == state.HURT:
		return
	if is_on_floor():
		if velocity == Vector2.ZERO:
			anim_state = state.IDLE
		elif velocity.x != 0:
			anim_state = state.RUNNING
	else:
		if velocity.y < 0:
			anim_state = state.JUMPUP
		else:
			anim_state = state.JUMPDOWN		
	if Input.is_action_pressed("jump") and is_on_floor():
		anim_state = state.CHARGE
		
	if anim_state == state.INTODOOR:
		return
	if anim_state == state.ATTACK:
		return
		

	
		
func update_animation(direction):
	if direction > 0:
		animator.flip_h = false
	elif direction < 0:
		animator.flip_h = true
	match anim_state:
		state.IDLE:
			sprite_2d_player.play("default")
		state.RUNNING:
			sprite_2d_player.play("running")
		state.JUMPUP:
			sprite_2d_player.play("jumpup")
		state.JUMPDOWN:
			sprite_2d_player.play("jumpDown")
		
		state.HURT:
			game_manager.add_deaths()
			sprite_2d_player.play("death")
			await sprite_2d_player.animation_finished  # Wait for the death animation to finish
			reset()  # Reset the character
		state.CHARGE:
			sprite_2d_player.play("charge")
		state.INTODOOR:
			sprite_2d_player.play("intoDoor")
		
func _physics_process(delta):
	# swing
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0

	# Handle jump charge.
	if Input.is_action_pressed("jump") and is_on_floor():
		is_charging = true
		charge_time += delta
		
		update_state()
	elif is_charging:
		# Release jump key: Jump with charge proportional to charge_time
		jump()
		
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
		if animator.is_flipped_h():
			velocity.x = WALL_JUMP_FORCE
			
		elif not animator.is_flipped_h():  # Character is moving left
			velocity.x = -WALL_JUMP_FORCE
			
			
	update_state()
	update_animation(direction)
	move_and_slide()
	
	animator.flip_h = isLeft
	


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
	update_state()
	
func play_walk_in_animation():
	if game_manager.keys == 1:
		$AnimationPlayer.play("intoDoor")
		
		print("intodoor")
		return
func enemy_hitter(enemy):
	if enemy.is_in_group("Hit"):
		enemy.die()

func enemy_checker(enemy):
	if enemy.is_in_group("Enemy") and anim_state == state.CHARGE:
		enemy.die()
		velocity.y = MAX_JUMP_HEIGHT
	 
	
	if enemy.is_in_group("Enemy") and velocity.y > 0:
		enemy.die()
		velocity.y = MAX_JUMP_HEIGHT
	elif(enemy.is_in_group("Hurt")):
		anim_state = state.HURT
func _on_hit_box_area_entered(area):
	enemy_checker(area)
	


func _on_hit_box_body_entered(body):
	enemy_checker(body)


