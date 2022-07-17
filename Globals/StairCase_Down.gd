extends Sprite


func randomise():
	var isArrow = RNGMan.LevelRNG.randi()%2
	if isArrow==0:
		$arrow.visible=false
	else:
		$arrow.visible=true
		$arrow.rotation=RNGMan.LevelRNG.randi()%360
	


func _on_Area2D_body_entered(body:KinematicBody2D):
	if body:
		if body.type == Glob.mobType.PLAYER:
			get_node("/root/Node2D/DungeonMasterGUI").reset_dungeon()
