extends CanvasLayer


func _on_StartGame_pressed():
	var target = "res://Scenes/DungeonMap.tscn"
	Glob.playerStats.reset()
	Glob.change_scene(target)


func _on_TestRoom_pressed():
	var target = "res://Scenes/TestScene.tscn"
	Glob.playerStats.reset()
	Glob.change_scene(target)
