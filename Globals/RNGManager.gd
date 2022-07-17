extends Node

var LevelRNG = RandomNumberGenerator.new()
var ActingRNG =  RandomNumberGenerator.new()#these are seperated so that level seeds can exist
var spinningText = []

func _ready():
	LevelRNG.randomize()
	ActingRNG.randomize()

func add_Dice(targetPos:Vector2, color:Color, isLevel:bool, scale:int)->Sprite:
	var newDie:Sprite = Glob.summonObject("Dice", self)
	newDie.position = targetPos + (Vector2(ActingRNG.randi()%7-3,ActingRNG.randi()%7-3)*scale*5)
	if isLevel:
		newDie.counter = 100+LevelRNG.randi()%10
	else:
		newDie.counter = 100+ActingRNG.randi()%10
	newDie.modulate = color
	newDie.scale = Vector2(scale,scale)
	newDie.useLevel = isLevel
	return newDie

func clear_dice():
	for child in get_children():
		child.queue_free()
