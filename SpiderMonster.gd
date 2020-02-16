extends KinematicBody2D
const FLOOR =  Vector2(0, -1)
var motion = Vector2()
const SPEED = 30
const GRAVITY = 10
var direction = 1

func _physics_process(delta):
	motion.x = SPEED * direction
	
	if direction == 1:
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false
	$Sprite.play("Walk")
	
	motion.y += GRAVITY
	
	motion = move_and_slide(motion, FLOOR)
	
	if is_on_wall():
		direction = direction * -1
		$RayCast2D.position.x *= -1
	
	#if $RayCast2D.is_colliding() == true:
		#direction = direction * -1
		#$RayCast2D.position.x *= -1
	
	


		
	
	