extends AudioStreamPlayer
class_name CustomStreamPlayer

export (Array, int) var beat_targets : Array
export var beat_offset_ms : int

func queuePlay():
	Music.queue_sound(self)
