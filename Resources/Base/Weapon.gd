extends Resource
class_name Weapon

export var affectType:String = "slash"
export var affectColor:Color = Color.blue
export var sprite:Texture
export var damage:int = 10
export var rangeLimit:int = 100
export var cooldown:int = 100
export var attackSpeed:int = 10
var cooldownTimer = 0
var affectTimer = 0


var isAttacking = false
var upswing = false


func attack(source:Node2D, direction:Vector2):
	#This function is a generic call, and can be overwritten
	#This version just does a basic jab
	var startpos = source.position
#	print("attacking!")
	var HB:Area2D = source.get_node("WeaponHitbox")
	HB.get_child(0).shape.b=direction*rangeLimit
	var hitThings = HB.get_overlapping_bodies()
	for object in hitThings:
		print("hit!")
		object.health-=1
		object.set_knockback(direction,500)
	if cooldownTimer <= 0:
		isAttacking=true
		upswing = true
	var affect = Glob.summonObject("LineEffect",source)
	affect.position=Vector2.ZERO#source.position
	affect.endPoint = direction*rangeLimit
	affect.color=Color.blue
