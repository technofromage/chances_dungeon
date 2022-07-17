extends Resource
class_name Weapon

export var affectType:String = "slash"
export var affectColor:Color = Color.blue
export var sprite:Texture
export var rangeLimit:int = 100
export var cooldown:int = 2#seconds
export var attackSpeed:int = 10#unused
export var knockBackAmount:int = 20
var cooldownTimer = 0


func processTimers(delta):
	if cooldownTimer>0:
		cooldownTimer-=delta
#		print(cooldownTimer)

func display_damage(target:Node2D, value):
	var textEffect = Glob.summonObject("TextEffect",target)
	textEffect.counter = 40
	textEffect.endPoint = Vector2(0,40)
	var newString = ""
	textEffect.color=Color.red
	newString = "-"+str(value)
	textEffect.targetString = newString

func calculateDamage()->int:
	return 1

func attack(source:Node2D, direction:Vector2)->bool:
	return false
