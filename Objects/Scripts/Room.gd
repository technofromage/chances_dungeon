extends Node2D

func clip(neighborsList):
	for neighbor in neighborsList:
		match(neighbor):
			Glob.dirs.TOP:
				clear_top()
			Glob.dirs.BOT:
				clear_bot()
			Glob.dirs.LEFT:
				clear_left()
			Glob.dirs.RIGHT:
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
		$TileMap.set_cell(5,i,-1)
