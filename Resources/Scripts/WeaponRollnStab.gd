extends Weapon

export var diceCount = 2
export var delay = 5#frames
var diceList = []
var hitDir:Vector2
var hitSource:Node2D

func processTimers(delta):
	if not diceList.empty():
		hitSource.velocity=Vector2(0,0)
		print("processTimer:",diceList[0].value)
		if diceList[0].value!=-1:
			attemptHit()
	.processTimers(delta)

func attack(source:Node2D, direction:Vector2)->bool:
	if cooldownTimer>0:
		return false
	for i in range(diceCount):
		var newDie = RNGMan.add_Dice(source.position,affectColor,false,1)
		newDie.counter = delay
		newDie.lifeSpan = 50
		diceList.append(newDie)
	cooldownTimer = cooldown
	hitDir = direction 
	hitSource = source
	return true

func attemptHit():
	var damage = calculateDamage()
	var rayCast:RayCast2D = hitSource.get_node("WeaponHitScan")
	hitSource.get_node("HitSound").play()
	rayCast.cast_to=hitDir*rangeLimit
	rayCast.force_raycast_update()
	var objectHit = rayCast.get_collider()
	if objectHit:
		print("hit!")
		objectHit.StatBlock.health -= damage
		display_damage(objectHit, damage)
		objectHit.set_knockback(hitDir,500)
	var affect = Glob.summonObject("LineEffect",hitSource)
	affect.position=Vector2.ZERO#source.position
	affect.endPoint = hitDir*rangeLimit
	affect.color=Color(.8,.8,.8,.5)
	affect.counter=15
	diceList.clear()
	

func calculateDamage():
	var sum = 0
	for die in diceList:
		print("SwordDie:", die.value)
		sum += (die.value+1)
	return sum
