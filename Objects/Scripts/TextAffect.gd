extends Node2D


var counter = 30.0
var endPoint = Vector2(0,20)
var color = Color.greenyellow
export var targetString:String
var incrementSpace = -1


func _process(delta):
	if incrementSpace == -1:
		incrementSpace = 1.0/counter
	color.a -= incrementSpace
	position+=endPoint*incrementSpace
	print("textPos:",position, endPoint)
	counter -= 1
	if counter < 0:
		queue_free()
	update()

func _draw():
	draw_string(Glob.debugFont,position, targetString, color)
