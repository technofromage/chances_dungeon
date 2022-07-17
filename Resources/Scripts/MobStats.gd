extends Resource
class_name Stats

export var poise = 40 #how quickly knockback is reduced
var OGPoise = poise
export var coins = 1 #how many coins do you drop on death
var OGcoins = coins
export var equipedWep:Resource
var OGequipedWep = equipedWep
export var speed = 150
var OGspeed = speed
export var maxHealth = 10
var OGmaxHealth = maxHealth
var health = maxHealth setget set_health

func set_health(value:int):
	health = value
	if health>maxHealth:
		health = maxHealth

func reset():
	maxHealth=OGmaxHealth
	health=OGmaxHealth
	speed = OGspeed
	poise = OGPoise
	coins = OGcoins
	
