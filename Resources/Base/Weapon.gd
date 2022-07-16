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
	print("attacking!")
	var HB = source.get_node("WeaponHitbox/CollisionShape2D")
	HB.shape.b=direction*rangeLimit
	if cooldownTimer <= 0:
		isAttacking=true
		upswing = true
