extends Node2D

var velocity = Vector2(0,0)
var speed = 100

func _unhandled_key_input(event):
	var input = Vector2(0,0)
	if Input.is_action_pressed("game_up"):
		input+=Vector2(0,-1)
	if Input.is_action_pressed("game_down"):
		input+=Vector2(0,1)
	if Input.is_action_pressed("game_left"):
		input+=Vector2(-1,0)
	if Input.is_action_pressed("game_right"):
		input+=Vector2(1,0)
	print(input)
	velocity = input.normalized()
		
func _physics_process(delta):
	translate(velocity*delta*speed)
