extends Sprite

var counter = 100
var useLevel = false
var value = -1
var tempValue:int

func _process(_delta):
	if counter>0:
		if useLevel:
			tempValue = RNGMan.LevelRNG.randi()%6
		else:
			tempValue = RNGMan.ActingRNG.randi()%6
		region_rect = Rect2(0,16*tempValue,16,16)
	if counter == 0:
		value = tempValue
		print("die:",value)
	if counter <=-200:
		queue_free()
	counter -= 1
