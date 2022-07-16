extends Mob

export var AI: Resource


func _ready():
	AI = AI.duplicate()#make the AI unique

func _process(_delta):
	if AI:
		AI.process(self)
	update()

func _draw():
	draw_line(Vector2(0,0), AI.wonderDirection*50,Color.blue,2)
	draw_line(Vector2(0,0), velocity*50,Color.green,2)
	
