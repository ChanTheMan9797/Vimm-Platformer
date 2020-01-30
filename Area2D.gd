extends Area2D


func ready():
	connect("body_entered", self, "_on_body_entered")
func _on_body_entered():
	print("YAY!?!")
	get_node("Floor").get("motion").x = -10


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
