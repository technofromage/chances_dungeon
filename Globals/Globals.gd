extends Node

enum dirs {
	TOP
	BOT
	LEFT
	RIGHT
}
enum mobType {
	PLAYER
	MONSTER
	BEAST
}

var debugFont = Control.new().get_font("font")#font used for debug 
var objects = preload("res://Globals/SpawnableObjects.tscn").instance()
var playerStats = load("res://Resources/PlayerStats.tres")


func summonObject(name, parent):#create a clone of an object from the other Scene
	var clone = objects.get_node(name).duplicate()
	parent.add_child(clone)
	return clone

func change_scene(target:String):
	print("changing scene:", target)
	var sceneError = get_tree().change_scene(target)
	if sceneError != OK:
		print("Error on scene change to",target,", error#:",sceneError)
		return
