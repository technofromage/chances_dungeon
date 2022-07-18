extends Panel

var selectedOptions: CustomOptions = OptionsMan.currentSettings.duplicate()

func readOptions():
	selectedOptions = OptionsMan.currentSettings
	$GridContainer/MusSlider.value = selectedOptions.MusicVol
	$GridContainer/SFXSlider.value = selectedOptions.SFXVol
	$GridContainer/MusMute.pressed = selectedOptions.MusicMute
	$GridContainer/SFXMute.pressed = selectedOptions.SFXMute

func _on_ApplyBut_pressed():
	selectedOptions.MusicVol = $GridContainer/MusSlider.value
	selectedOptions.SFXVol = $GridContainer/SFXSlider.value
	selectedOptions.MusicMute = $GridContainer/MusMute.pressed
	selectedOptions.SFXMute = $GridContainer/SFXMute.pressed
	OptionsMan.currentSettings = selectedOptions


func _on_CloseBut_pressed():
	selectedOptions = OptionsMan.currentSettings.duplicate()
	visible = false
