extends KinematicBody2D

var motion = Vector2()

# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	motion.x = 100
	
	motion = move_and_slide(motion)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
