extends KinematicBody2D


const ACCEL = 512
const MAX_SPEED = 64
const SPRINT_MULTIPLIER = 1.7
const FRICTION = 0.25
const AIR_RESISTANCE = 0.02
const GRAVITY = 200
const MAX_GRAVITY = 400
const JUMP_FORCE = 150


var motion = Vector2.ZERO

onready var sprite = $Sprite
onready var animation_player = $AnimationPlayer
func _physics_process(delta):
	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	move(delta, x_input)
		
	motion.y += GRAVITY * delta
	
	if motion.y > MAX_GRAVITY:
		motion.y = MAX_GRAVITY
	
	
	
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = -JUMP_FORCE
		if x_input == 0:
			motion.x = lerp(motion.x, 0, FRICTION)
	else:
		animation_player.play("jump")
		if Input.is_action_just_released("ui_up") and motion.y < -JUMP_FORCE/2:
			motion.y = -JUMP_FORCE/2
			
		
		if x_input == 0:
			motion.x = lerp(motion.x, 0, AIR_RESISTANCE)
			
		if Input.is_action_just_pressed("ui_down"):
			
			motion.y = (GRAVITY /2) 
		
	motion = move_and_slide(motion, Vector2.UP)

func move(delta, x_input):
	
	if x_input == 0:
		animation_player.play("Stand")
	elif Input.is_key_pressed(KEY_SHIFT):
		animation_player.playback_speed = 1.3
		_sprint(delta, x_input)
	else:
		animation_player.playback_speed = 1
		_run(delta, x_input)
		
	
func _run(delta, x_input):
	animation_player.play("Run")
	motion.x += x_input * ACCEL * delta
	motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
	sprite.flip_h = x_input < 0
	

func _sprint(delta, x_input):
	#sprite.get	
	animation_player.play("Run")
	motion.x += x_input * ACCEL * delta
	motion.x = clamp(motion.x, -MAX_SPEED * SPRINT_MULTIPLIER, MAX_SPEED * SPRINT_MULTIPLIER)
	sprite.flip_h = x_input < 0
		
		
	
