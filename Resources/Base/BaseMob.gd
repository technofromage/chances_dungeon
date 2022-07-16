extends KinematicBody2D
class_name Mob

export var equipedWep:Resource
var velocity = Vector2(0,0)
var speed = 150
export var MaxHealth = 10
var health = MaxHealth

func _physics_process(delta):
	move_and_slide(velocity*speed)
