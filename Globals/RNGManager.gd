extends Node

var LevelRNG = RandomNumberGenerator.new()
var ActingRNG =  RandomNumberGenerator.new()#these are seperated so that level seeds can exist
var spinningText = []

func _process(_delta):
	for textSpinner in spinningText:
		textSpinner.change()
		textSpinner.timer -= 1
		if (textSpinner.timer < 0):
			spinningText.erase(textSpinner)

func spinText(textSpinner:SpinningLabel):
	spinningText.append(textSpinner)

func add_Dice(targetPos:Vector2, color:Color, isLevel:bool, scale:int)->Sprite:
	var newDie:Sprite = Glob.summonObject("Dice", self)
	newDie.position = targetPos + (Vector2(ActingRNG.randi()%7-3,ActingRNG.randi()%7-3)*scale*5)
	if isLevel:
		newDie.counter = 100+LevelRNG.randi()%10
	else:
		newDie.counter = 100+ActingRNG.randi()%10
	newDie.modulate = color
	newDie.scale = Vector2(scale,scale)
	newDie.useLevel = isLevel
	return newDie
