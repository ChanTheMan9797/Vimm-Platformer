extends KinematicBody2D

const GRAVITY = 10 
const WALK = 60
const RUN = 120
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
		if $Right.is_colliding() == false:
			direction = direction * -1
			$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
			$Right.position.x *= -1
	
	elif state == IDLE:
		idle()

	else:
		pass

	timer += delta
	if timer >= wait:
		timer = 0
		emit_signal("timeout")




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
	elif rando == 1:
		state = STEP
