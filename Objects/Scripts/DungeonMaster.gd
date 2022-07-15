extends Node2D

var path = []
var offshoots = []

var length = 1

func _ready():
	pass
#	make_path(randi()%4+1)


var counter = 3
func _process(delta):
	if counter == 0:
		length+=1
		make_path(length)
		counter = 20
	counter -= 1
	update()

func make_path(length):
	#sets the path node to contain length nodes starting from 0,0
	path = []
	var currentPos = Vector2(0,0)
	var pathValid
	var direction = Vector2(0,0)
	for i in range(length):
		pathValid = false
		var attempts = 0
		while (not pathValid):
			attempts+=1
			if attempts > 10:#easy check for when path cuts itself off
				return
			var choice = (randi()%4)
			match(choice):
				0:
					direction = Vector2(1,0)#right
				1:
					direction = Vector2(0,1)#up
				2:
					direction = Vector2(-1,0)#left
				3:
					direction = Vector2(0,-1)#down
			if not path.has(currentPos+(direction*12)):
				currentPos = currentPos+(direction*12)
				path.append(currentPos)
				pathValid = true

func _draw():
	for point in path:
		draw_circle(point,10,Color.blue)
	draw_string(Glob.debugFont,Vector2(-10,-10),String(counter),Color.green)
