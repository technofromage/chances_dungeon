extends ItemList

export var DMPath: NodePath
var DM
var spinningText = []

const mainTextFormat = "Count:%s \nLvl:%s"

func _ready():
	DM = get_node(DMPath)

func _process(delta):
	update()
	var debugString = mainTextFormat % [String(DM.counter),String(DM.difficulty)]
	$MainText.text = debugString


func _draw():
	for point in DM.path:
		draw_circle(point*8+Vector2(75,50),4,Color.blue)
