extends Node2D
onready var message = get_node("message")
onready var tname = get_node("Name")
var typing = false
var index = 0
var s
var tmp
var nm
var i = 0
var dia = ["Nick:This is a text box example!", "Chan:I am trying to replicate Final Fantasy or Zelda type dialouge.", "Nick:I apologize for my typos I'll stop now."]
var t = Timer.new()
func _ready():
	t.set_wait_time(3)
	self.add_child(t)
	
func _process(delta):
	if Input.is_action_just_pressed("space"):
		tmp = dia[index]
		tmp = tmp.split(":")
		nm = tmp[0]
		s = tmp[1]
		i=0
		index += 1
		typing = true
		message.text = ""
	if typing:
		tname.text = nm
		message.text += s[i]
		OS.delay_msec(10)
		i += 1
		
		if message.text.length() == s.length():
			i = 0
			typing = false
	

func typewords(s):
	message.text = ""
	for i in range(s.length()):
		message.text += s[i]
		OS.delay_msec(10)
		