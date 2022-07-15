extends Panel

var selectedOptions: CustomOptions

func readOptions():
	#read the current options from the optionsManager and load them into the drop downs above
	pass

func _on_ApplyBut_pressed():
	visible = false


func _on_CancelBut_pressed():
	visible = false
