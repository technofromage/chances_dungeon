extends Sprite

var counter = 100 #how many seconds spent rolling
var useLevel = false #determines which rng tracker to use
var value = -1
var tempValue:int
var lifeSpan = 200 #how many seconds after rolling to show dice
#THIS DICE TRACKS FROM 0->5 DEFAULT

func _ready():
	var sound = Music.diceAffectOptions[RNGMan.ActingRNG.randi()%3]
	$AudioStreamPlayer2D.stream = sound
	$AudioStreamPlayer2D.play()
	
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
