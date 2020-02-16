extends KinematicBody2D

const GRAVITY = 10 
const WALK = 60
const RUN = 150
const FLOOR = Vector2(0, -1)
const IDLE = "idle"
const STEP = "step"
const CHARGE = "charge"
const ATTACK =  "attack"

var velocity = Vector2()
var direction = 1 
var state = STEP
var rando = 0
var rand = 0
var timer = 0
var wait = .5
var left = false
var right = true
signal timeout

func _ready():
	pass


func _physics_process(delta):
	if state == STEP:
		velocity.x = WALK * direction
		$AnimatedSprite.play("Walk")
		velocity.y += GRAVITY
		velocity = move_and_slide(velocity, FLOOR) 
	
			
		if is_on_wall():
			direction = direction * -1
			$Right.position.x *= -1
			$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
			left = !left
			right = !right
		if $Right.is_colliding() == false:
			direction = direction * -1
			$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
			left = !left
			right = !right
			$Right.position.x *= -1
		timer += delta
		if timer >= wait:
			timer = 0
			emit_signal("timeout")
	
	elif state == IDLE:
		idle()
		velocity.x = 0
		velocity.y += GRAVITY
		velocity = move_and_slide(velocity, FLOOR) 
		timer += delta
		if timer >= wait:
			timer = 0
			emit_signal("timeout")

	elif state == CHARGE:
		velocity.x = RUN * direction
		velocity.y += GRAVITY
		velocity = move_and_slide(velocity, FLOOR) 
	




func idle():
	$AnimatedSprite.play("Idle")


func _on_Enemy_timeout():
	rando = randi()%2
	wait = randf()*3+1

	if rando == 0:
		state = IDLE
		rand = randi()%100
		if rand >= 70:
			$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h	
			direction *= -1
			$Right.position.x *= -1
			left = !left
			right = !right
	elif rando == 1:
		state = STEP

func _on_Look_body_exited(body):
	state = IDLE


func _on_LookLeft_body_entered(body):
	if body.get_name() == "Player":
	
		state = CHARGE
		$AnimatedSprite.play("Run")
		if right == true:
			$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h	
			$Right.position.x *= -1
			direction *= -1
			right = false
			left = true


func _on_LookLeft_body_exited(body):
	state = IDLE


func _on_LookRight_body_entered(body):
	if body.get_name() == "Player":
		state = CHARGE
		$AnimatedSprite.play("Run")
		if left == true:
			$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h	
			$Right.position.x *= -1
			direction *= -1
			left = false
			right = true


func _on_LPunch_body_entered(body):
	if body.get_name() == "Player":
		state = ATTACK
		$AnimatedSprite.play("Attack")
		if right == true:
			$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h	
			$Right.position.x *= -1
			direction *= -1
			right = false
			left = true
		


func _on_LPunch_body_exited(body):
	state = CHARGE
	$AnimatedSprite.play("Run")

func _on_RPunch_body_entered(body):
	if body.get_name() == "Player":
		state = ATTACK
		$AnimatedSprite.play("Attack")
		if left == true:
			$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h	
			$Right.position.x *= -1
			direction *= -1
			left = false
			right = true


func _on_RPunch_body_exited(body):
	state = CHARGE
	$AnimatedSprite.play("Run")
