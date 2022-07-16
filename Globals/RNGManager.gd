extends Node

var rng = RandomNumberGenerator.new()
var spinningText = []


func _process(_delta):
	for textSpinner in spinningText:
		textSpinner.change()
		textSpinner.timer -= 1
		if (textSpinner.timer < 0):
			spinningText.erase(textSpinner)

func spinText(textSpinner:SpinningLabel):
	spinningText.append(textSpinner)
