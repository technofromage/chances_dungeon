extends KinematicBody2D
class_name Mob

enum mobType {
	PLAYER
	MONSTER
	BEAST
}
export var StatBlock:Resource
export (mobType) var type:int
var velocity = Vector2(0,0)
var knockbackVal = 0.0
var knockbackDirection = Vector2(0,0)


func _ready():
	if StatBlock.equipedWep:
		StatBlock.equipedWep = StatBlock.equipedWep.duplicate()
		$WeaponSprite.texture=StatBlock.equipedWep.sprite

func _physics_process(delta):
	if StatBlock.health <= 0:
		process_death()
	
	if StatBlock.equipedWep:
		StatBlock.equipedWep.processTimers(delta)
	
	if knockbackVal>10:#loose controll
		move_and_slide(knockbackDirection*knockbackVal)
		knockbackVal-=StatBlock.poise
	elif knockbackVal>0:#parial controll
		move_and_slide(velocity*StatBlock.speed+knockbackDirection*knockbackVal)
		knockbackVal-=StatBlock.poise
	else:#full controll
		move_and_slide(velocity*StatBlock.speed)

func set_knockback(direction:Vector2, value:int):
	knockbackVal = value
	knockbackDirection = direction

func process_death():#TODO: drop loot
	#especcially important to bo overwritten in the player mob
	queue_free()
