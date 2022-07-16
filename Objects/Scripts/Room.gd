extends Node2D

func clip(neighborsList):
	for neighbor in neighborsList:
		match(neighbor):
			Glob.TOP:
				clear_top()
			Glob.BOT:
				clear_bot()
			Glob.LEFT:
				clear_left()
			Glob.RIGHT:
				clear_right()

func clear_top():
	for i in range(-5,4):
		$TileMap.set_cell(i,-6,-1)
func clear_bot():
	for i in range(-5,4):
		$TileMap.set_cell(i,5,-1)
func clear_left():
	for i in range(-5,4):
		$TileMap.set_cell(-6,i,-1)
func clear_right():
	for i in range(-5,4):
		$TileMap.set_cell(i,5,-1)
