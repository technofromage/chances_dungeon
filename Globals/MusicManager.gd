extends Node

var musicPlayer : AudioStreamPlayer
const BPM = 140
const SPB = 0.4286
const mesLen = 4 #beats per measure

var musicClock = 0
var musicMode = 1
var _currentTrackMode = 1
var _lastTimeChecked = 0
var _currentBeat = 0
var _musicTimer = 0
#const _musicTrackLen = 16#beats

#this will be a 2-D array containing streams to be played
var _soundQueue : Array = [[],[],[],[]]


func _process(delta):
	musicClock += delta
	if (musicClock-_lastTimeChecked>SPB):
		_currentBeat += 1
		_currentBeat %= mesLen
		_musicTimer += 1
		_musicTimer %= _musicTrackLen
		_lastTimeChecked=musicClock
		
		for sound in _soundQueue[_currentBeat]:
			print("playing:", sound, _currentBeat)
			sound.play()
		_soundQueue[_currentBeat].clear()
		
		if (_musicTimer == 0):
			musicPlayer.play()
	

#places the sound into the queue
func queue_sound(sound:CustomStreamPlayer):
	var beatTargets = sound.beat_targets
	if (len(beatTargets)==0):
		#if none are given, assume all beats are valid
		beatTargets = range(mesLen)
	assert(len(beatTargets)>0)
	var i = _currentBeat
	while (not beatTargets.has(i)):
		i+=1
		i%=mesLen
	_soundQueue[i].append(sound)

#gets the time to next beat # (ie: beat #1 is first beat in measure)
#if targetBeat == -1 then gets time for next beat
func time_to_next_beat(targetBeat:int):
	pass


