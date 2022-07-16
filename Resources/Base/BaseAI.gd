extends Resource

var prevDirection = Vector2(0,0)
var wonderDirection = Vector2(0,0)
var wonderTimer = 5
func process(source:Node2D):
	#print("processing", source)
	#this is a basic function to be overwritten
	#this version just makes the guys walk around a bit
	var scanBox:Area2D = source.get_node("AIHitbox")
	if wonderTimer == 0:
		var wiggleX = (RNGMan.ActingRNG.randi()%3)-1
		var wiggleY = (RNGMan.ActingRNG.randi()%3)-1
		wonderDirection =  Vector2(wiggleX,wiggleY)
		wonderTimer = 40
	wonderTimer-=1
	var targetVelocity = wonderDirection
	var collisions = scanBox.get_overlapping_bodies()
	for thing in collisions:#if see player, wall, or other monster
		#var parent = thing.get_parent()
		var directionToObject = source.position.direction_to(thing.position)
		var distanceToObject = source.position.distance_to(thing.position)
		match(thing.type):
			Glob.mobType.MONSTER:
				targetVelocity += directionToObject*distanceToObject*(-1)#move away from friend
			Glob.mobType.PLAYER:
				targetVelocity += directionToObject*(distanceToObject-60)#move towards enimy, but stay safe distance
	source.velocity = (targetVelocity.normalized()*0.2)+(prevDirection*0.8)
	prevDirection = source.velocity
	
