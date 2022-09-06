extends AudioStreamPlayer

var silenceTimer = 4
var inGame = false
var fadeout = false
var waitingPlayer = null #the audioPlayer we are waiting from
var pausePos	# the point to resume the pause from

var musicOptions = [
	preload("res://Audio/HoliznaCC0 - Rising Hero.ogg"),
	preload("res://Audio/Defrini - Spookie.ogg"),
	preload("res://Audio/Rolemusic - Alamak.ogg")
]
var diceAffectOptions = [
	preload("res://Audio/dice_roll1.wav"),
	preload("res://Audio/dice_roll2.wav"),
	preload("res://Audio/dice_roll3.wav")
]
var nextStream:AudioStream = preload("res://Audio/Rolemusic - Alamak.ogg")
var deathMusic = preload("res://Audio/HoliznaCC0 - NPC Theme.ogg")
var deathRequest = false

export var normVolume = -15 #db

func _ready():
	bus = "Music"
	stream = musicOptions[2]
	pause_mode=Node.PAUSE_MODE_PROCESS
	volume_db = normVolume
	

func reset():
	fadeout = true
	deathRequest = false
	inGame = false

func _process(_delta):
	if fadeout:
		if volume_db > -40:
			volume_db -= 1
			return
		else:
			#in case of resuming later, we can pause
			pausePos = get_playback_position() 
			stop()
			fadeout = false
			volume_db = normVolume
	if inGame:
		if waitingPlayer!=null:	#we are paused and are waiting for someone
			if waitingPlayer.playing==false:
				waitingPlayer=null
				play(pausePos)
				return
		else:
			if not playing:
				print("MM>", silenceTimer)
				if silenceTimer == 0:
					stream = nextStream
					nextStream = musicOptions[RNGMan.ActingRNG.randi()%len(musicOptions)]
					play()
					silenceTimer = RNGMan.ActingRNG.randi()%50+100
				else:
					silenceTimer -= 1
	
	if deathRequest:
		stream = deathMusic
		play()
		deathRequest = false
		inGame = false

func request_death():
	print("requesting death music")
	inGame = false
	if playing:
		fadeout = true
		deathRequest = true

func pauseForJingle(jinglePlayer):
	waitingPlayer = jinglePlayer
	fadeout = true
	
