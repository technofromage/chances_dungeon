extends KinematicBody2D
class_name Mob

enum mobType {
	PLAYER
	MONSTER
	BEAST
}
export (mobType) var type:int
export var equipedWep:Resource
export var speed = 150
export var MaxHealth = 10
var health = MaxHealth
var velocity = Vector2(0,0)

func _physics_process(delta):
	move_and_slide(velocity*speed)
