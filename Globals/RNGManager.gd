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
