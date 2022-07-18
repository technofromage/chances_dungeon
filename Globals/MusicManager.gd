extends AudioStreamPlayer

var silenceTimer = 4
var inGame = false
var fadeout = false

var musicOptions = [
	preload("res://Audio/HoliznaCC0 - Rising Hero.ogg"),
	preload("res://Audio/Defrini - Spookie.ogg"),
	preload("res://Audio/Rolemusic - Alamak.ogg")
]
var nextStream:AudioStream = preload("res://Audio/Rolemusic - Alamak.ogg")
var deathMusic = preload("res://Audio/HoliznaCC0 - NPC Theme.ogg")
var deathRequest = false

func _ready():
	bus = "Music"
	stream = musicOptions[2]
	pause_mode=Node.PAUSE_MODE_PROCESS

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
			stop()
			fadeout = false
			volume_db = 0
	if inGame:
		if not playing:
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
		
