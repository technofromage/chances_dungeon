extends Label
class_name SpinningLabel
#this text is spun by the RNG manager

export (Array, String) var textOptions;
export (int) var currentOption
var counter = 0
var useLevel = false
var value = -1

var tempValue
func _process(_delta):
	if counter>0:
		if useLevel:
			tempValue = RNGMan.LevelRNG.randi()%len(textOptions)
		else:
			tempValue = RNGMan.ActingRNG.randi()%len(textOptions)
		text = textOptions[tempValue]
		counter -= 1
	if counter == 0:
		value = textOptions[tempValue]
		text = value
		print("spinner:",value)
		print("spinnertText:",text)

