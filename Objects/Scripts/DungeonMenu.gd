extends Panel

export var DMPath: NodePath
var DM
var spinningText = []

const mainTextFormat = "Stage:%s \nCount:%s \nLvl:%s"

func _ready():
	DM = get_node(DMPath)
	Glob.playerStats.start()

func _process(_delta):
	update()
	var debugString = mainTextFormat % [String(DM.processStage),String(DM.counter),String(DM.difficulty)]
	$MainText.text = debugString
	$healthBar.max_value = Glob.playerStats.maxHealth
	$healthBar.value = Glob.playerStats.health

func clear_Text():
	spinningText = []
	for child in $RoomsText.get_children():
		child.queue_free()

func create_Text():
	var newLabel:SpinningLabel = Glob.summonObject("SpinningLabel", $RoomsText)
	newLabel.textOptions = RoomsData.roomNames
	newLabel.counter = RNGMan.LevelRNG.randi()%70+50
	newLabel.useLevel = true
	return newLabel

func _draw():
	for point in DM.path:
		draw_circle(point*8+Vector2(75,50),4,Color.blue)
