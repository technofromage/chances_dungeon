extends AudioStreamPlayer
class_name CustomStreamPlayer

export (Array, int) var beat_targets : Array
export var beat_offset_ms : int
export (Array, AudioStream) var soundList

func playfromList():
	stream = soundList[RNGMan.ActingRNG.randi()%len(soundList)]
	play()
