extends Node

var currentSettings:CustomOptions  = preload("res://Resources/Options.tres") setget applySettings

func _ready():
	applySettings(currentSettings)

func applySettings(newSettings:CustomOptions):
	currentSettings = newSettings
	AudioServer.set_bus_mute(1,currentSettings.MusicMute)
	AudioServer.set_bus_mute(2,currentSettings.SFXMute)
	AudioServer.set_bus_volume_db(1,currentSettings.MusicVol)
	AudioServer.set_bus_volume_db(2,currentSettings.SFXVol)
	
