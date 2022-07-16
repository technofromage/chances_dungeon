extends Node2D

var counter = 10.0
var endPoint = Vector2(100,100)
var color = Color.greenyellow

func _process(delta):
	counter -= 0.4
	if counter < 0:
		queue_free()
	update()

func _draw():
	draw_line(Vector2.ZERO, endPoint, color, counter)
