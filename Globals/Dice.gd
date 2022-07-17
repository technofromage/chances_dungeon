extends Sprite

var counter = 100
var useLevel = false
var value = -1
var tempValue:int
var lifeSpan = 200

func _process(_delta):
	if counter>0:
		if useLevel:
			tempValue = RNGMan.LevelRNG.randi()%6
		else:
			tempValue = RNGMan.ActingRNG.randi()%6
		region_rect = Rect2(0,16*tempValue,16,16)
	if counter == 0:
		value = tempValue
		print("dieResult:",value)
	if counter <=-lifeSpan:
		queue_free()
	counter -= 1
