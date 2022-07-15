extends CanvasLayer


func _input(event):
	if (event.is_echo() || !event.is_pressed()):
		return
	if Input.is_action_just_pressed("global_pause"):
		print("pause toggle")
		if get_tree().paused:
			get_tree().paused = false
			$Buttons.visible = false
		else:
			get_tree().paused = true
			$Buttons.visible = true


func _on_Continue_pressed():
		get_tree().paused = false
		$Buttons.visible = false

func _on_Quit_pressed():
	get_tree().quit()

func _on_Main_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/MainMenu.tscn")

func _on_Options_pressed():
	$OptionsMenu.visible = true
