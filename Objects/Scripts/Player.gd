extends Mob


func _unhandled_input(event):
	var input = Vector2(0,0)
	if Input.is_action_pressed("game_up"):
		input+=Vector2(0,-1)
	if Input.is_action_pressed("game_down"):
		input+=Vector2(0,1)
	if Input.is_action_pressed("game_left"):
		input+=Vector2(-1,0)
	if Input.is_action_pressed("game_right"):
		input+=Vector2(1,0)
#	print(input)
	velocity = input.normalized()
	if Input.is_action_pressed("game_attack") or ( event is InputEventMouseButton):
		var attackDir = get_global_mouse_position()
		attackDir = position.direction_to(attackDir)
#		print("Player>",attackDir)
#		print("Player>",attackDir-position)
		StatBlock.equipedWep.attack(self, attackDir)

func _process(_delta):
	update()

func process_death():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")

func _draw():
	draw_line(Vector2(-10,40),Vector2(-10+StatBlock.equipedWep.cooldownTimer*2,40),Color.red,4)
	
