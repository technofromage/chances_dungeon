extends Weapon

func attack(source:Node2D, direction:Vector2)->bool:
	if cooldownTimer>0:
		return false
	source.get_node("HitSound").play()
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
		display_damage(objectHit, 1)
		objectHit.set_knockback(direction,500)
	var affect = Glob.summonObject("LineEffect",source)
	affect.position=Vector2.ZERO#source.position
	affect.endPoint = direction*rangeLimit
	affect.color=Color(.8,.8,.8,.5)
	return true
