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

func summonObject(name, parent):#create a clone of an object from the other Scene
	var clone = objects.get_node(name).duplicate()
	parent.add_child(clone)
	return clone
