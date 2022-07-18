extends Mob

var objectOfIntrest:Node2D = null
var dead = false

func _unhandled_input(event):
	if dead:
		return
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
	if Input.is_action_just_pressed("game_pickup"):
		if objectOfIntrest!=null:
			if (StatBlock.equipedWep):
				var newObject = Glob.summonObject("DroppedWeapon",get_node("/root/Node2D/LootContainer"))
				print("dropping:",StatBlock.equipedWep)
				newObject.weapon = StatBlock.equipedWep
				newObject.position = position
			StatBlock.equipedWep = objectOfIntrest.weapon
			objectOfIntrest.queue_free()
			$WeaponSprite.texture=StatBlock.equipedWep.sprite
			$PickupSound.play()

func _process(_delta):
	var OverlapList = $PickupArea.get_overlapping_areas()
	if not OverlapList.empty():
		objectOfIntrest = OverlapList[0].get_parent()
	else:
		objectOfIntrest = null
	update()

func process_death():
	if dead:
		return
	velocity = Vector2(0,0)
	knockbackVal = 0
	$CollisionShape2D.disabled=true
	Music.request_death()
	var camera = get_node("/root/Node2D/ZoomedoutCam")
	var DM = get_node("/root/Node2D/DungeonMasterGUI")
	dead = true
	if camera:
		$Camera2D.current=false
		camera.current=true
		DM.show_menu()
		$Player_GUI/GameOverScreen.visible=true
		$Sprite.modulate = Color.gray
	else:
		get_tree().change_scene("res://Scenes/MainMenu.tscn")
		Music.inGame = false
		Music.fadeout = true

func _draw():
	draw_line(Vector2(-10,40),Vector2(-10+StatBlock.equipedWep.cooldownTimer*8,40),Color.green,5)
	if objectOfIntrest != null:
		print("OOI:",objectOfIntrest.position)
		draw_circle(objectOfIntrest.position-position+Vector2(16,16),10,Color.green)
		draw_string(Glob.debugFont, objectOfIntrest.position-position+Vector2(12,20), 'E')
	
