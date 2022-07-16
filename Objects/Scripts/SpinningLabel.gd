extends Label
class_name SpinningLabel
#this text is spun by the RNG manager

export (Array, String) var textOptions;
export (int) var currentOption
var timer = 0
var isLevel = false

func change():
	var index
	if isLevel:
		index = RNGMan.LevelRNG.randi()%len(textOptions)
	else:
		index = RNGMan.ActingRNG.randi()%len(textOptions)
	text = textOptions[index]
