extends Resource
class_name Stats

export var poise = 40 #how quickly knockback is reduced
var OGPoise
export var coins = 1 #how many coins do you drop on death
var OGcoins
export var equipedWep:Resource
var OGequipedWep
export var speed = 150
var OGspeed
export var maxHealth = 10
var OGmaxHealth
var health = 1 setget set_health
var parent:Node2D


func start():
	OGPoise = poise
	OGcoins = coins
	OGequipedWep = equipedWep
	OGspeed = speed
	OGmaxHealth = maxHealth
	health = maxHealth


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
	
