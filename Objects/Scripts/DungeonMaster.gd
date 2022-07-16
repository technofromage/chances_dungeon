extends Node2D

var path = []
var offshoots = []
var destination:Vector2
var difficulty = 1
var roomCount = 1
var counter = 0#decremented to represent wait times to let info sink in
#TODO: consider "fast mode" option
var processStage = 0#increment this tool when the stage is done

enum stages{
	PATH,
	ROOMS,
	MONSTERS,
	LOOT,
	WAIT,
	START,
	RESET
	}
	
func _process(delta):
	match(processStage):
		stages.PATH:
			make_path()
		stages.ROOMS:
			place_rooms()
		stages.MONSTERS:
			place_monsters()
		stages.LOOT:
			place_loot()
		stages.WAIT:
			wait_for_player()
		stages.START:
			start_game()
		stages.RESET:
			reset_dungeon()
	update()

func reset_dungeon():
	counter = 0
	path = []
	processStage = 0
	difficulty+=1

func make_path():
	var length = (randi()%4+difficulty)
	#sets the path node to contain length nodes starting from 0,0
	if counter == 0:
		var currentPos = Vector2(0,0)
		var pathValid
		var direction = Vector2(0,0)
		path.append(Vector2(0,0))
		roomCount = 0
		for i in range(length):
			pathValid = false
			var attempts = 0
			while (not pathValid):
				attempts+=1
				if attempts > 10:#easy check for when path cuts itself off
					return
				var choice = (randi()%4)
				match(choice):
					0:
						direction = Vector2(1,0)#right
					1:
						direction = Vector2(0,1)#up
					2:
						direction = Vector2(-1,0)#left
					3:
						direction = Vector2(0,-1)#down
				if not path.has(currentPos+(direction)):
					currentPos = currentPos+(direction)
					path.append(currentPos)
					roomCount += 1
					pathValid = true
		destination = currentPos #desination is the last viewed position
		counter = 20
	counter -= 1
	if counter == 0:
		processStage+=1
		return true
	else:
		return false
		

func place_rooms():
	pass
func place_monsters():
	pass
func place_loot():
	pass
func wait_for_player():
	pass
func start_game():
	pass




func _on_Button_pressed():
	reset_dungeon()
