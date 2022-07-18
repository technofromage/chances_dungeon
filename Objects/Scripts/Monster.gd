extends Mob

export var AI: Resource


func _ready():
	StatBlock = StatBlock.duplicate()
	StatBlock.start()
	AI = AI.duplicate()#make the AI unique
	._ready()

func _process(_delta):
	if AI:
		AI.process(self)
	update()

func _draw():
	draw_line(Vector2(-15,25),Vector2(-15+StatBlock.maxHealth*4,25),Color.gray,4)
	draw_line(Vector2(-15,25),Vector2(-15+StatBlock.health*4,25),Color.red,4)
#	draw_string(Glob.debugFont, Vector2(100,100), str(StatBlock.health))
#	draw_line(Vector2(0,0), AI.wonderDirection*50,Color.blue,2)
#	draw_line(Vector2(0,0), velocity*50,Color.green,2)
	
