extends Resource
class_name Weapon

export var affectType:String = "slash"
export var affectColor:Color = Color.blue
export var sprite:Texture
export var damage:int = 10
export var rangeLimit:int = 100
export var cooldown:int = 2#seconds
export var attackSpeed:int = 10#unused
var cooldownTimer = 0
var affectTimer = 0


var isAttacking = false
var upswing = false

func processTimers(delta):
	if cooldownTimer>0:
		cooldownTimer-=delta
#		print(cooldownTimer)


func attack(source:Node2D, direction:Vector2)->bool:
	if cooldownTimer>0:
		return false
	cooldownTimer = cooldown
	#This function is a generic call, and can be overwritten
	#This version just does a basic jab
#	print("attacking!")
	var rayCast:RayCast2D = source.get_node("WeaponHitScan")
	rayCast.cast_to=direction*rangeLimit
	rayCast.force_raycast_update()
	var objectHit = rayCast.get_collider()
	if objectHit:
		print("hit!")
		objectHit.StatBlock.health -= 1
		objectHit.set_knockback(direction,500)
	if cooldownTimer <= 0:
		isAttacking=true
		upswing = true
	var affect = Glob.summonObject("LineEffect",source)
	affect.position=Vector2.ZERO#source.position
	affect.endPoint = direction*rangeLimit
	affect.color=Color(.8,.8,.8,.5)
	return true
