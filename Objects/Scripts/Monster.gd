extends Mob

export var AI: Resource


func _ready():
	AI = AI.duplicate()#make the AI unique

func _process(_delta):
	if AI:
		AI.process(self)
	update()

func _draw():
	draw_line(Vector2(-10,40),Vector2(-10+health*10,40),Color.red,4)
#	draw_line(Vector2(0,0), AI.wonderDirection*50,Color.blue,2)
#	draw_line(Vector2(0,0), velocity*50,Color.green,2)
	
