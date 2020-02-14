extends KinematicBody2D
const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 250
const JUMP_HEIGHT = -600
var extraJumps = 1
var motion = Vector2()
var on_ground = false
var jumps = 0

# Player Motion

func _physics_process(delta):
	motion.y += GRAVITY
	
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
	else:
		motion.x = 0
		
	if is_on_floor():
		on_ground = true
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
	
	if Input.is_action_pressed("Restart"):
		get_tree().reload_current_scene()
	#Player Animation
	
	if is_on_floor():
		if motion.x == 0:
			$Sprite.play("Idle")
		elif motion.x < 0:
			$Sprite.flip_h = true
			$Sprite.play("Run")
		elif motion.x > 0:
			$Sprite.flip_h = false
			$Sprite.play("Run")
	else:
		if motion.y < 0:
			$Sprite.play("Jump")
			if motion.x < 0:
				$Sprite.flip_h = true
			elif motion.x >= 0:
				$Sprite.flip_h = false
		else:
			$Sprite.play("Fall")
			if motion.x < 0:
				$Sprite.flip_h = true
			elif motion.x >= 0:
				$Sprite.flip_h = false
	


	motion = move_and_slide(motion, UP)
	pass
	