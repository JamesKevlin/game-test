extends KinematicBody2D


const ACCEL = 512
const MAX_SPEED = 64
const FRICTION = 0.25
const AIR_RESISTANCE = 0.02
const GRAVITY = 200
const MAX_GRAVITY = 400
const JUMP_FORCE = 128


var motion = Vector2.ZERO

onready var sprite = $Sprite
onready var animation_player = $AnimationPlayer
func _physics_process(delta):
	
	if Input.is_key_pressed(KEY_D) and not Input.is_key_pressed(KEY_A) :
		motion.x += ACCEL * delta
		animation_player.play("Run")
		motion.x += 1 * ACCEL * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
		sprite.flip_h = false
		
	elif Input.is_key_pressed(KEY_A) and not Input.is_key_pressed(KEY_D):
		motion.x += -1 * ACCEL * delta
		animation_player.play("Run")
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
		sprite.flip_h = true
	else:
		motion.x = lerp(motion.x, 0, FRICTION)
		animation_player.play("Stand")
		
	motion.y += GRAVITY * delta
	
	if motion.y > MAX_GRAVITY:
		motion.y = MAX_GRAVITY
	
	if is_on_floor():
		if Input.is_key_pressed(KEY_W):
			motion.y = -JUMP_FORCE

			
	else:
		animation_player.play("jump")
		
		if Input.is_key_pressed(KEY_W) and motion.y < -JUMP_FORCE/2:
			motion.y = -JUMP_FORCE/2
			
		
#		if x_input == 0:
	#		motion.x = lerp(motion.x, 0, AIR_RESISTANCE)
			
		if Input.is_key_pressed(KEY_S):
			
			motion.y = (GRAVITY /2) 

	motion = move_and_slide(motion, Vector2.UP)
