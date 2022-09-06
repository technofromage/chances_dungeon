tool
extends Sprite
class_name Relic

export var description:String
export(Glob.statusType) var status
export var weight:int
const itemType = "relic"


func take():
	match status:
		Glob.statusType.COINS:
			Glob.playerStats.coins+=weight
		Glob.statusType.HEALTH:
			Glob.playerStats.health+=weight
		Glob.statusType.MAX_HEALTH:
			Glob.playerStats.maxHealth+=weight
			Glob.playerStats.health+=weight
		Glob.statusType.SPEED:
			Glob.playerStats.speed+=weight
	
