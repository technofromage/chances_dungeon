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
export var maxHealth = 10
var health = maxHealth
var velocity = Vector2(0,0)
var knockbackVal = 0.0
var knockbackDirection = Vector2(0,0)
export var poise = 40 #how quickly knockback is reduced
export var coins = 1 #how many coins do you drop on death


func _ready():
	if equipedWep:
		$WeaponSprite.texture=equipedWep.sprite

func _physics_process(delta):
	if health == 0:
		process_death()
	
	if equipedWep:
		equipedWep.processTimers(delta)
	
	if knockbackVal>10:#loose controll
		move_and_slide(knockbackDirection*knockbackVal)
		knockbackVal-=poise
	elif knockbackVal>0:#parial controll
		move_and_slide(velocity*speed+knockbackDirection*knockbackVal)
		knockbackVal-=poise
	else:#full controll
		move_and_slide(velocity*speed)

func set_knockback(direction:Vector2, value:int):
	knockbackVal = value
	knockbackDirection = direction

func process_death():#TODO: drop loot
	#especcially important to bo overwritten in the player mob
	queue_free()
