extends Node

const roomNames = [\
	"Basic Room",
	"Alternative Room",
	"Tiny Room",
	"Walls Room"
]

var mobNames = [\
	"MonsterSmall",
	"MonsterBig"
]

var weapons = [
	load("res://Resources/Weapons/RollnStab.tres"),
	load("res://Resources/Weapons/RollnStabHeavy.tres"),
	load("res://Resources/Weapons/Stab.tres")
]

var roomAssets = {\
	"Basic Room":preload("res://Objects/Rooms/Room_Basic.tscn"),
	"Alternative Room":preload("res://Objects/Rooms/Room_Spire.tscn"),
	"Tiny Room":preload("res://Objects/Rooms/Room_Void.tscn"),
	"Walls Room":preload("res://Objects/Rooms/Room_Walled.tscn")
}

