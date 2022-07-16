extends Label
class_name SpinningLabel
#this text is spun by the RNG manager

export (Array, String) var textOptions;
export (int) var currentOption
var timer = 0


func change():
	var index = randi()%len(textOptions)
	text = textOptions[index]
