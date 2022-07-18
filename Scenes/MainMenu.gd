extends CanvasLayer


func _on_StartGame_pressed():
	var target = "res://Scenes/DungeonMap.tscn"
	Glob.playerStats.reset()
	Glob.change_scene(target)


func _on_Options_pressed():
	$OptionsMenu.visible=true
	$OptionsMenu.readOptions()

func _on_ReturnCredits_pressed():
	$Credits.visible = false

func _on_Credits_pressed():
	$Credits.visible = true
