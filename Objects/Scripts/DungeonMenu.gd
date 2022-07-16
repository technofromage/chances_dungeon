extends Panel

export var DMPath: NodePath
var DM
var spinningText = []

const roomTypes = ["Room Basic", "Room Square"]

const mainTextFormat = "Count:%s \nLvl:%s"

func _ready():
	DM = get_node(DMPath)

func _process(_delta):
	update()
	var debugString = mainTextFormat % [String(DM.counter),String(DM.difficulty)]
	$MainText.text = debugString

func clear_Text():
	spinningText = []
	for child in $RoomsText.get_children():
		child.queue_free()

func create_Text():
	var newLabel:SpinningLabel = Glob.summonObject("SpinningLabel", $RoomsText)
	newLabel.textOptions = roomTypes
	newLabel.timer = randi()%70+50
	RNGMan.spinText(newLabel)
	return newLabel

func _draw():
	for point in DM.path:
		draw_circle(point*8+Vector2(75,50),4,Color.blue)
