extends CanvasLayer

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
	PLAY,
	RESET
	}

var diceDictionary = {}

func _ready():
	Music.inGame = true

func _process(_delta):
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

func show_menu():
	$DungeonText.visible=true
	$StartButton.visible=false

func reset_dungeon():
	counter = 0
	path = []
	processStage = 0
	difficulty+=1
	diceDictionary.clear()
	readyToGo=false
	show_menu()
	$DungeonText.clear_Text()
	get_node("../ZoomedoutCam").current=true
	for child in get_node("../RoomContainer").get_children():
		child.queue_free()
	for child in get_node("../MobContainer").get_children():
		child.queue_free()
	for child in get_node("../LootContainer").get_children():
		child.queue_free()
	Glob.playerStats.health += 1

func make_path():
	var length = (RNGMan.LevelRNG.randi()%4+difficulty)
	#sets the path node to contain length nodes starting from 0,0
	if counter == 0:
		var currentPos = Vector2(0,0)
		var pathValid
		var direction = Vector2(0,0)
		path.append(Vector2(0,0))
		roomCount = 0
		for _i in range(length):
			pathValid = false
			var attempts = 0
			while (not pathValid):
				attempts+=1
				if attempts > 10:#easy check for when path cuts itself off
					return
				var choice = (RNGMan.LevelRNG.randi()%4)
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
		counter = 25
	counter -= 1
	if counter == 0:
		processStage+=1
		return true
	else:
		return false

func place_rooms():
	if counter == 0:
		diceDictionary.clear()
		for point in path:
			var spinner = $DungeonText.create_Text()
			diceDictionary[spinner] = point
		counter = 1
	else:#there WILL be at least 1 path, so at least one room
		for spinner in diceDictionary.keys():
			if spinner.counter<=0:
				print("roomType:",spinner.text)
				summon_room(spinner.text, diceDictionary[spinner])
				diceDictionary.erase(spinner)#done so that the call won't trigger twice
		if diceDictionary.empty():#ie: once all spinners have stoped
			processStage+=1
			counter = 0


func place_monsters():
	if counter==0:
		diceDictionary.clear()
		for i in range(1,len(path)):
			var newDice = RNGMan.add_Dice(path[i]*5*64, Color.white,true,4)
			diceDictionary[newDice] = path[i]
			counter += 1
	for dice in diceDictionary.keys():
		if dice.value!=-1:
			summon_monster(dice.value, diceDictionary[dice])
			diceDictionary.erase(dice)#done so that the call won't trigger twice
			counter-=1
	if counter<=0:
		processStage+=1

func place_loot():
	if counter==0:
		diceDictionary.clear()
		
		var stairs = Glob.summonObject("StairCase_Down",get_node("../LootContainer"))
		stairs.position = destination*5*64
		stairs.randomise()
		
		var weaponDie = RNGMan.add_Dice(Vector2(100,100), Color.white,true,3)
		diceDictionary[0] = weaponDie
		var powerupDie = RNGMan.add_Dice(Vector2(0,80), Color.blue,true,3)
		diceDictionary[1] = powerupDie
		
		counter = 2
	if diceDictionary[0].value!=-1:
			var newThing = Glob.summonObject("DroppedWeapon",get_node("../LootContainer"))
			newThing.position = path[diceDictionary[0].value%len(path)]*5*64 + Vector2(RNGMan.LevelRNG.randi()%31-15,RNGMan.LevelRNG.randi()%31-15)
			newThing.weapon = RoomsData.weapons[RNGMan.LevelRNG.randi()%len(RoomsData.weapons)]
			diceDictionary[0].value = -1
			counter -=1
	if diceDictionary[1].value!=-1:
			var newThing = Glob.summonObject("HealthUp",get_node("../LootContainer"))
			newThing.position = path[diceDictionary[1].value%len(path)]*5*64 + Vector2(RNGMan.LevelRNG.randi()%71-35,RNGMan.LevelRNG.randi()%71-35)
			diceDictionary[1].value = -1
			counter -=1
	if counter == 0:
		processStage+=1

var readyToGo = false
func wait_for_player():
	if counter==0:
		counter = 1
		readyToGo=false
		$StartButton.visible=true
	if readyToGo:#this will get changed when the button is pressed
		processStage+=1
		counter = 0

func start_game():
	#summon player
	var player = Glob.summonObject("Player", get_node("../MobContainer"))
	player.position = Vector2(0,0)
	player.get_node("Camera2D").current=true
	get_node("../ZoomedoutCam").current=false
	$DungeonText.visible=false
	processStage+=1
	RNGMan.clear_dice()
	


func summon_room(name, pathPoint):#this function will put a room with the name "name" onto the place for pathpoint
	var neighborsArray = get_neighbors_on_path(pathPoint)
	var clone:Node2D = RoomsData.roomAssets[name].instance().duplicate()
	get_node("../RoomContainer").add_child(clone)
	clone.position = pathPoint*5*64
	clone.clip(neighborsArray)

func summon_monster(value, pathPoint):
	var clone
	if value==0:
		return
	elif value==5:
		clone = Glob.summonObject("MonsterBig",get_node("../MobContainer"))
	else:
		clone = Glob.summonObject("MonsterSmall",get_node("../MobContainer"))
	clone.position = (pathPoint*5*64)+Vector2(RNGMan.LevelRNG.randi()%31-15,RNGMan.LevelRNG.randi()%31-15)

func get_neighbors_on_path(pathPoint):
	var newArray = []
	if path.has(pathPoint+Vector2(0,-1)):
		newArray.append(Glob.dirs.TOP)
	if path.has(pathPoint+Vector2(0,1)):
		newArray.append(Glob.dirs.BOT)
	if path.has(pathPoint+Vector2(1,0)):
		newArray.append(Glob.dirs.RIGHT)
	if path.has(pathPoint+Vector2(-1,0)):
		newArray.append(Glob.dirs.LEFT)
	return newArray


func _on_Button_pressed():
	reset_dungeon()


func _on_StartButton_pressed():
	readyToGo=true#this will intiate the end of the wait_for_player function
	$StartButton.visible=false
